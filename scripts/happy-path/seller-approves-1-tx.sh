#!/usr/bin/env bash

set -eux

DATUM_PREFIX=${1:-0}

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

$baseDir/core/approves-unlock-tx.sh \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buyer-approved.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buyer-approved-hash.txt) \
  "$tempDir/$BLOCKCHAIN_PREFIX/redeemers/$DATUM_PREFIX/seller-approves.json" \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  ~/$BLOCKCHAIN_PREFIX/seller.skey \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
   d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456 \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  "8000000 lovelace" \
  $(cat ~/$BLOCKCHAIN_PREFIX/marketplace.addr) \
  "1000000 lovelace" \
  $(cat ~/$BLOCKCHAIN_PREFIX/royalities.addr) \
  "1000000 lovelace"
