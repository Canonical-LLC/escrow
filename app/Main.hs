{-# LANGUAGE LambdaCase #-}

module Main where

import Cardano.Api hiding (TxId)

import Canonical.Escrow
import Prelude
import System.Environment

main :: IO ()
main = do
  [filePath] <- getArgs

  writeFileTextEnvelope filePath Nothing swap >>= \case
    Left err -> print $ displayError err
    Right () -> putStrLn $ "wrote NFT validator to file " ++ filePath
