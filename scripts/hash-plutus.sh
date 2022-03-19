cardano-cli address build \
  --payment-script-file ./scripts/escrow.plutus \
  $BLOCKCHAIN \
  --out-file scripts/$BLOCKCHAIN_PREFIX/escrow.addr
