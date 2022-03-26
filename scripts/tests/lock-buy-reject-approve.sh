#!/usr/bin/env bash

set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/lock-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/buy-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/seller-rejects-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/mediator-approves-tx.sh
$baseDir/wait/until-next-block.sh
