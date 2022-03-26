{-# LANGUAGE DataKinds #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module Canonical.Escrow
  ( Payout(..)
  , Swap(..)
  , SwapState(..)
  , SwapTransition(..)
  , swap
  ) where

import Cardano.Api.Shelley (PlutusScript(..), PlutusScriptV1)
import Codec.Serialise (serialise)
import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString.Short as SBS
import Ledger (Address(..), Datum(..), POSIXTime, PubKeyHash, after, before)
import Ledger.Typed.Scripts
import Plutus.V1.Ledger.Contexts
import Plutus.V1.Ledger.Credential
import Plutus.V1.Ledger.Value
import PlutusTx
import qualified PlutusTx.AssocMap as M
import PlutusTx.AssocMap (Map)
import PlutusTx.Prelude

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

data Payout = Payout
  { pAddress :: !PubKeyHash
  , pValue :: !Value
  }

data Swap = Swap
  { sOwner :: !PubKeyHash
  -- ^ Used for the signer check on Cancel
  , sSwapValue :: !Value
  -- ^ Value the owner is offering up
  , sSwapPayouts :: ![Payout]
  -- ^ Divvy up the payout to different address for Swap
  , sDeadline :: !POSIXTime
  -- ^ Offers are only accepted until this deadline. If an offer has
  -- been made and the deadline passes before both parties have approved
  -- the swap, the decision of whether to accept the offer or not goes
  -- into mediation.
  , sMediator :: !PubKeyHash
  -- ^ Who gets the final decision in mediation
  }

data BuyerPayouts = BuyerPayouts
  { bpBuyer :: !PubKeyHash
  , bpUnlockerPayouts :: ![Payout]
  }

data Escrow = Escrow
  { eSwap :: !Swap
  , eBuyerPayouts :: !BuyerPayouts
  }

data Approval
  = NoApproval
  | ApprovedBy !PubKeyHash
  | RejectedBy !PubKeyHash
  | ApprovedByRejectedBy !PubKeyHash !PubKeyHash

data SwapState
  = OnOffer !Swap
  | InEscrow !Approval !Escrow
  -- ^ Can represent a few different states after a buy has been made:
  -- * We're waiting for approval from the seller and buyer, e.g. []
  -- * One of the buyer or seller has approved, e.g. [(x, True)]
  -- * One of the buyer or seller has rejected, and possibly the other has approved

data SwapTransition
  = Cancel
  | Buy BuyerPayouts
  | Approve (PubKeyHash, Bool)

-------------------------------------------------------------------------------
-- Utilities
-------------------------------------------------------------------------------
isScriptAddress :: Address -> Bool
isScriptAddress Address { addressCredential } = case addressCredential of
  ScriptCredential _ -> True
  _ -> False

-- Verify that there is only one script input and get it's value.
getOnlyScriptInput :: TxInfo -> Value
getOnlyScriptInput info =
  let
    isScriptInput :: TxInInfo -> Bool
    isScriptInput = isScriptAddress . txOutAddress . txInInfoResolved

    input = case filter isScriptInput . txInfoInputs $ info of
      [i] -> i
      _ -> traceError "expected exactly one script input"
  in txOutValue . txInInfoResolved $ input

payoutToInequality :: Payout -> (PubKeyHash, Value)
payoutToInequality Payout {..} = (pAddress, pValue)

mergePayoutsValue :: [Payout] -> Value
mergePayoutsValue = foldr (\x acc -> pValue x <> acc) mempty

paidAtleastTo :: TxInfo -> PubKeyHash -> Value -> Bool
paidAtleastTo info pkh val = valuePaidTo info pkh `geq` val

mergeInequalities :: Map PubKeyHash Value -> Map PubKeyHash Value -> Map PubKeyHash Value
mergeInequalities = M.unionWith (+)

mergeAll :: [Map PubKeyHash Value] -> Map PubKeyHash Value
mergeAll = foldr mergeInequalities M.empty

-------------------------------------------------------------------------------
-- Boilerplate
-------------------------------------------------------------------------------
instance Eq Payout where
  x == y = pAddress x == pAddress y && pValue x == pValue y

instance Eq Swap where
  x == y =
    sOwner x == sOwner y && sSwapPayouts x == sSwapPayouts y && sDeadline x == sDeadline y && sMediator x == sMediator y

instance Eq BuyerPayouts where
  x == y = bpBuyer x == bpBuyer y && bpUnlockerPayouts x == bpUnlockerPayouts y

instance Eq Escrow where
  x == y = eSwap x == eSwap y && eBuyerPayouts x == eBuyerPayouts y

instance Eq Approval where
  x == y = case (x, y) of
    (NoApproval, NoApproval) -> True
    (NoApproval, _) -> False
    (ApprovedBy a, ApprovedBy a') -> a == a'
    (ApprovedBy _, _) -> False
    (RejectedBy a, RejectedBy a') -> a == a'
    (RejectedBy _, _) -> False
    (ApprovedByRejectedBy a b, ApprovedByRejectedBy a' b') -> a == a' && b == b'
    (ApprovedByRejectedBy _ _, _) -> False

instance Eq SwapState where
  x == y = case (x, y) of
    (OnOffer a, OnOffer a') -> a == a'
    (OnOffer _, _) -> False
    (InEscrow a b, InEscrow a' b') -> a == a' && b == b'
    (InEscrow _ _, _) -> False

instance Eq SwapTransition where
  x == y = case (x, y) of
    (Cancel, Cancel) -> True
    (Cancel, _) -> False
    (Buy a, Buy a') -> a == a'
    (Buy _, _) -> False
    (Approve a, Approve a') -> a == a'
    (Approve _, _) -> False

PlutusTx.unstableMakeIsData ''Payout
PlutusTx.unstableMakeIsData ''Swap
PlutusTx.unstableMakeIsData ''BuyerPayouts
PlutusTx.unstableMakeIsData ''Approval
PlutusTx.unstableMakeIsData ''Escrow
PlutusTx.unstableMakeIsData ''SwapState
PlutusTx.unstableMakeIsData ''SwapTransition

-------------------------------------------------------------------------------
-- Validation
-------------------------------------------------------------------------------
-- check that each user is paid
-- and the total is correct
validateOutputConstraints :: TxInfo -> Map PubKeyHash Value -> Bool
validateOutputConstraints info constraints = all (uncurry (paidAtleastTo info)) $ M.toList constraints

-- Every branch but user initiated cancel requires checking the input
-- to ensure there is only one script input.
swapValidator :: SwapState -> SwapTransition -> ScriptContext -> Bool
swapValidator st t ctx =
  let
    info :: TxInfo
    info = scriptContextTxInfo ctx

    outputInfo o = case txOutAddress o of
      Address (ScriptCredential _) _ -> case txOutDatumHash o of
        Just h -> case findDatum h info of
          Just (Datum d) -> case PlutusTx.fromBuiltinData d of
            Just b -> (txOutValue o, b)
            _ -> traceError "parsing output datum failed"
          _ -> traceError "output datum not found"
        _ -> traceError "no output datum hash"
      _ -> traceError "unexpected output address"

    scriptOutputValue :: Value
    scriptOutputDatum :: SwapState
    (scriptOutputValue, scriptOutputDatum) = case getContinuingOutputs ctx of
      [o] -> outputInfo o
      _ -> traceError "expected a single continuing output"

    scriptInput :: Value
    scriptInput = getOnlyScriptInput info

    signedBy = txSignedBy info

    signedByOwner = signedBy theOwner

    (theOwner, theMediator, theSwap) = case st of
      OnOffer s -> (sOwner s, sMediator s, s)
      InEscrow _ e -> (sOwner . eSwap $ e, sMediator . eSwap $ e, eSwap e)

    isBeforeDeadline :: Bool
    isBeforeDeadline = sDeadline theSwap `after` txInfoValidRange info

    theSwapValue :: Value
    theSwapValue = sSwapValue theSwap

    swapPayoutValue :: Value
    swapPayoutValue = mergePayoutsValue . sSwapPayouts $ theSwap
  in case st of
    OnOffer s -> case t of
      Approve _ -> traceError "not in escrow"

      Cancel -> traceIfFalse "not signed by seller" signedByOwner

      Buy bp ->
        let
          unlockerPayoutValue :: Value
          unlockerPayoutValue = mergePayoutsValue . bpUnlockerPayouts $ bp

          scriptInputIsValid :: Bool
          scriptInputIsValid = scriptInput `geq` unlockerPayoutValue

          outputsAreValid :: Bool
          outputsAreValid = scriptOutputValue `geq` (scriptInput <> swapPayoutValue)

          outputDatumIsValid :: Bool
          outputDatumIsValid = scriptOutputDatum == InEscrow NoApproval (Escrow s bp)
        in
          traceIfFalse "wrong output value" outputsAreValid
          && traceIfFalse "wrong output datum" outputDatumIsValid
          && traceIfFalse "wrong input value" scriptInputIsValid
          && traceIfFalse "too late" isBeforeDeadline

    InEscrow approval escrow -> case t of
      Cancel -> traceError "in escrow"

      Buy _ -> traceError "in escrow"

      Approve (pkh, approves) ->
        let
          theBuyer = bpBuyer . eBuyerPayouts $ escrow

          unlockerPayoutValue :: Value
          unlockerPayoutValue = mergePayoutsValue . bpUnlockerPayouts . eBuyerPayouts $ escrow

          canApprove :: Bool
          canApprove = pkh `elem` [theOwner, theBuyer, theMediator]

          swapApprovedOutputIsValid =
            validateOutputConstraints info
              . mergeAll
              . map (uncurry M.singleton . payoutToInequality)
              . mappend (sSwapPayouts . eSwap $ escrow)
              $ bpUnlockerPayouts (eBuyerPayouts escrow)

          rejected = case approval of
            NoApproval -> False
            ApprovedBy _ -> False
            RejectedBy _ -> True
            ApprovedByRejectedBy _ _ -> True

          scriptInputIsValid = scriptInput `geq` (unlockerPayoutValue <> swapPayoutValue)

          sOutGeqIn = traceIfFalse "script output should be >= script input" (scriptOutputValue `geq` scriptInput)

          outputDatumCheck = traceIfFalse "output datum is wrong"

          mkApproval = if approves then ApprovedBy else RejectedBy

          buyerOwnerChecks = traceIfFalse "deadline passed, in mediation" isBeforeDeadline && case approval of
            RejectedBy _ -> traceError "rejected, in mediation"

            ApprovedByRejectedBy _ _ -> traceError "rejected, in mediation"

            NoApproval ->
              -- this is the first approval or we're going into mediation.
              -- either way, script value shouldn't change
              --
              -- we expect the output datum to be the same, but with the
              -- approval or rejection added
              sOutGeqIn && outputDatumCheck (scriptOutputDatum == InEscrow (mkApproval pkh) escrow)

            ApprovedBy pkh' | pkh == pkh' ->
              -- user is either resubmitting their approval or we're going into mediation.
              -- either way, script value shouldn't change
              --
              -- we expect the output datum to be the same, but with the
              -- approval or rejection replacing the previous value
              sOutGeqIn && outputDatumCheck (scriptOutputDatum == InEscrow (mkApproval pkh') escrow)

            ApprovedBy pkh' -> if approves
              then
                -- both users have approved.
                -- check the payouts are going where they should
                   traceIfFalse "script output is wrong" swapApprovedOutputIsValid
              else
                -- we're going into mediation. the script value shouldn't change
                -- we check that the output datum is the same as before, but with
                -- the rejection added
                   sOutGeqIn && outputDatumCheck (scriptOutputDatum == InEscrow (ApprovedByRejectedBy pkh' pkh) escrow)

          mediatorChecks =
            let
              inMediation = sDeadline theSwap `before` txInfoValidRange info || rejected

              outputIsValid = if approves
                then swapApprovedOutputIsValid
                else
                  -- make sure the seller gets back the value they offered up and
                  -- the buyer gets back what they paid
                     let in paidAtleastTo info theOwner theSwapValue && paidAtleastTo info theBuyer swapPayoutValue
            in traceIfFalse "not in mediation" inMediation && traceIfFalse "output is not valid" outputIsValid
        in
          traceIfFalse "script input wrong" scriptInputIsValid
          && traceIfFalse "cannot approve or reject" canApprove
          && traceIfFalse "not signed by approver" (signedBy pkh)
          && if pkh == theMediator then mediatorChecks else buyerOwnerChecks

-------------------------------------------------------------------------------
-- Entry Points
-------------------------------------------------------------------------------
data Swapping
instance ValidatorTypes Swapping where
  type DatumType Swapping = SwapState
  type RedeemerType Swapping = SwapTransition

validator :: TypedValidator Swapping
validator =
  mkTypedValidator @Swapping
    $$(PlutusTx.compile [|| swapValidator ||])
    $$(PlutusTx.compile [|| wrap ||])
  where
    wrap = wrapValidator

swap :: PlutusScript PlutusScriptV1
swap = PlutusScriptSerialised $ SBS.toShort $ LB.toStrict $ serialise $ validatorScript validator
