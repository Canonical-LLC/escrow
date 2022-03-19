
user=${1:-seller}

./scripts/minting/test-mint-tx.sh \
  $(cardano-cli-balance-fixer collateral --address $(cat ~/$BLOCKCHAIN_PREFIX/$user.addr) $BLOCKCHAIN) \
   scripts/test-policies/test-policy-1.plutus \
   $(cat scripts/test-policies/test-policy-1-id.txt) 123456 1 $user
