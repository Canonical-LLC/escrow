#!/usr/bin/env bash

set -eux

DATUM_PREFIX=${1:-0}

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

$baseDir/core/swap-buy-tx.sh \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/offer.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/offer-hash.txt) \
  "$tempDir/$BLOCKCHAIN_PREFIX/redeemers/$DATUM_PREFIX/buy.json" \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-hash.txt) \
  ~/$BLOCKCHAIN_PREFIX/buyer.skey \
  d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456 \
  10000000
