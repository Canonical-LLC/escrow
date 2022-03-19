set -eu
thisDir=$(dirname "$0")
mainDir=$thisDir/..

(
cd $mainDir
cabal run exe:create-smart-contract -- scripts/escrow.plutus
)

$thisDir/hash-plutus.sh
