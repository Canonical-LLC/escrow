#!/usr/bin/env bash

set -eux

DATUM_PREFIX=${1:-0}

thisDir=$(dirname "$0")
baseDir=$thisDir/../..
tempDir=$baseDir/../temp

$baseDir/core/one-approves-tx.sh \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-nopayment.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-nopayment-hash.txt) \
  "$tempDir/$BLOCKCHAIN_PREFIX/redeemers/$DATUM_PREFIX/seller-approves.json" \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-approved-nopayment.json \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/seller-approved-nopayment-hash.txt) \
  ~/$BLOCKCHAIN_PREFIX/seller.skey \
  d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456

