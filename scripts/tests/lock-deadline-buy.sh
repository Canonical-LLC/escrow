#!/usr/bin/env bash

set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/lock-1-tx.sh
$baseDir/wait/until-next-block.sh

detected=false

"$baseDir/happy-path/buy-tx.sh" || {
  detected=true
}

if [ $detected == false ]; then
  exit 1
fi

