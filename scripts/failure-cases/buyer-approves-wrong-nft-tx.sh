#!/usr/bin/env bash

set -eux

DATUM_PREFIX=${1:-0}

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

$baseDir/core/approves-unlock-tx.sh \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-approved.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-approved-hash.txt) \
  "$tempDir/$BLOCKCHAIN_PREFIX/redeemers/$DATUM_PREFIX/buyer-approves.json" \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
  ~/$BLOCKCHAIN_PREFIX/buyer.skey \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
   380eab015ac8e52853df3ac291f0511b8a1b7d9ee77248917eaeef10.123456 \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  "8000000 lovelace" \
  $(cat ~/$BLOCKCHAIN_PREFIX/marketplace.addr) \
  "1000000 lovelace" \
  $(cat ~/$BLOCKCHAIN_PREFIX/royalities.addr) \
  "1000000 lovelace"


