#!/usr/bin/env bash

set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/nopayment/lock-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/nopayment/buy-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/nopayment/seller-approves-tx.sh
$baseDir/wait/until-next-block.sh
$baseDir/happy-path/nopayment/buyer-approves-tx.sh
$baseDir/wait/until-next-block.sh

