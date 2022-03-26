#!/usr/bin/env bash

set -eux

thisDir=$(dirname "$0")
baseDir=$thisDir/../

bodyFile=temp/approves-unlock-tx-body.01
outFile=temp/approves-unlock-tx.01
datumFile="${1}"
datumHash="${2}"
redeemerFile="${3}"
approverAddress="${4}"
signingKey="${5}"
buyerAddr="${6}"
value="${7}"
sellerAddr="${8}"
sellerAmount="${9}"
marketplaceAddr="${10}"
marketPlaceAmount="${11}"
royalitiesAddr="${12}"
royalitiesAmount="${13}"

nftValidatorFile=$baseDir/escrow.plutus
scriptHash=$(cat scripts/$BLOCKCHAIN_PREFIX/escrow.addr)

utxoScript=$(scripts/query/sc.sh | grep $datumHash | grep "$value" | head -n 1 | cardano-cli-balance-fixer parse-as-utxo)
output1=$(cardano-cli-balance-fixer utxo-assets --utxo $utxoScript $BLOCKCHAIN)
changeOutput=$(cardano-cli-balance-fixer change --address $approverAddress $BLOCKCHAIN)
currentSlot=$(cardano-cli query tip $BLOCKCHAIN | jq .slot)
startSlot=$currentSlot
nextTenSlots=$(($currentSlot+150))

extraOutput=""
if [ "$changeOutput" != "" ];then
  extraOutput="+ $changeOutput"
fi

cardano-cli transaction build \
    --alonzo-era \
    $BLOCKCHAIN \
    $(cardano-cli-balance-fixer input --address $approverAddress $BLOCKCHAIN ) \
    --tx-in $utxoScript \
    --tx-in-script-file $nftValidatorFile \
    --tx-in-datum-file $datumFile \
    --tx-in-redeemer-file $redeemerFile \
    --required-signer $signingKey \
    --tx-in-collateral $(cardano-cli-balance-fixer collateral --address $approverAddress $BLOCKCHAIN ) \
    --tx-out "$sellerAddr + $sellerAmount" \
    --tx-out "$buyerAddr + 1724100 lovelace + 1 $value" \
    --tx-out "$marketplaceAddr + $marketPlaceAmount" \
    --tx-out "$royalitiesAddr + $royalitiesAmount" \
    --tx-out "$approverAddress + 3000000 lovelace $extraOutput" \
    --change-address $approverAddress \
    --protocol-params-file $baseDir/$BLOCKCHAIN_PREFIX/protocol-parameters.json \
    --invalid-before $startSlot \
    --invalid-hereafter $nextTenSlots \
    --out-file $bodyFile

cardano-cli transaction sign \
   --tx-body-file $bodyFile \
   --signing-key-file $signingKey \
   $BLOCKCHAIN \
   --out-file $outFile

cardano-cli transaction submit \
  $BLOCKCHAIN \
  --tx-file $outFile
