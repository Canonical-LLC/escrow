set -eux

baseDir="scripts"

bodyFile=temp/swap-tx-body.01
outFile=temp/swap-tx.01
datumFile="${1}"
datumHash="${2}"
redeemerFile="${3}"
spenderAddress="${4}"
outDatumFile="${5}"
outDatumHash="${6}"
signingKey="${7}"
value="${8}"
amount="${9}"

nftValidatorFile=$baseDir/escrow.plutus
scriptHash=$(cat scripts/$BLOCKCHAIN_PREFIX/escrow.addr)

utxoScript=$(scripts/query/sc.sh | grep $datumHash | head -n 1 | cardano-cli-balance-fixer parse-as-utxo)
output1=$(cardano-cli-balance-fixer utxo-assets --utxo $utxoScript $BLOCKCHAIN)
changeOutput=$(cardano-cli-balance-fixer change --address $spenderAddress $BLOCKCHAIN)
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
  $(cardano-cli-balance-fixer input --address $spenderAddress $BLOCKCHAIN ) \
  --tx-in $utxoScript \
  --tx-in-script-file $nftValidatorFile \
  --tx-in-datum-file $datumFile \
  --tx-in-redeemer-file $redeemerFile \
  --required-signer $signingKey \
  --tx-in-collateral $(cardano-cli-balance-fixer collateral --address $spenderAddress $BLOCKCHAIN ) \
  --tx-out "$scriptHash + $output1 + $amount lovelace" \
  --tx-out-datum-hash $outDatumHash \
  --tx-out-datum-embed-file $outDatumFile \
  --tx-out "$spenderAddress + 3000000 lovelace $extraOutput" \
  --change-address $spenderAddress \
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
