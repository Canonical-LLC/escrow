#!/usr/bin/env bash

set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/lock-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/buy-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/seller-approves-tx.sh
$baseDir/wait/until-next-block.sh

detected=false

"$baseDir/failure-cases/buyer-approves-too-little-royalties-tx.sh" || {
  detected=true
}

if [ $detected == false ]; then
  exit 1
fi

