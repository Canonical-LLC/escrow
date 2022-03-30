#!/usr/bin/env bash

set -eux

thisDir=$(dirname "$0")

$thisDir/lock-cancel.sh
$thisDir/lock-buy-sellerapprove-buyerapprove.sh
$thisDir/lock-buy-buyerapprove-sellerapprove.sh
$thisDir/lock-buynopayment-approve-approve.sh
$thisDir/lock-buy-reject-approve.sh
$thisDir/lock-buy-approve-reject-approve.sh
$thisDir/lock-buy-reject-reject.sh
$thisDir/lock-buy-approve-reject-reject.sh
$thisDir/lock-buy-deadline-mediator-approve.sh

$thisDir/lock-buy-cancel.sh
$thisDir/lock-buy-reject-cancel.sh
$thisDir/lock-deadline-buy.sh
$thisDir/lock-buy-deadline-approve.sh
$thisDir/nft-goes-to-wrong-address.sh
$thisDir/too-little-ada.sh
$thisDir/too-little-fees.sh
$thisDir/too-little-royalties.sh

# TODO we don't get to the validator because the final tx creation fails: it is unable to find the nft on the script in order to pick a utxo
# $thisDir/wrong-nft.sh
