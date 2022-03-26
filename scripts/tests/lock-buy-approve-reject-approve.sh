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
$baseDir/happy-path/seller-approves-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/buyer-rejects-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/mediator-approves-2-tx.sh
$baseDir/wait/until-next-block.sh
