#!/usr/bin/env bash

set -eux

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

DATUM_PREFIX=${1:-0}

$baseDir/core/cancel-tx.sh \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  ~/$BLOCKCHAIN_PREFIX/seller.skey \
  d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456 \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-rejected.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-rejected-hash.txt) \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr)
