{-# LANGUAGE LambdaCase #-}

module Main where

import Cardano.Api                         hiding (TxId)

import Canonical.Escrow
import System.Environment
import Prelude

main :: IO ()
main = do
  [filePath] <- getArgs

  writeFileTextEnvelope filePath Nothing swap >>= \case
    Left err -> print $ displayError err
    Right () -> putStrLn $ "wrote NFT validator to file " ++ filePath
