set -eux

WALLETS_DIR=~/$BLOCKCHAIN_PREFIX
mkdir -p $WALLETS_DIR

if [ ! -f $WALLETS_DIR/$1.vkey  ]; then
  cardano-cli address key-gen --verification-key-file $WALLETS_DIR/$1.vkey --signing-key-file $WALLETS_DIR/$1.skey
  cardano-cli address build $BLOCKCHAIN --payment-verification-key-file $WALLETS_DIR/$1.vkey --out-file $WALLETS_DIR/$1.addr
fi
