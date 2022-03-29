#!/usr/bin/env bash

set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/lock-2-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/buy-tx.sh
$baseDir/wait/until-next-block.sh

sleep 240s

detected=false

"$baseDir/happy-path/seller-approves-tx.sh" || {
  detected=true
}

if [ $detected == false ]; then
  exit 1
fi


