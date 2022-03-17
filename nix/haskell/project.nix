{ haskell-nix
, lib
, libsodium-vrf
, parseIndexState
, plutus
}:

haskell-nix.project {
  inherit (plutus.plutus-apps.haskell) compiler-nix-name;

  src = haskell-nix.haskellLib.cleanGit {
    name = "warp-hello-src";
    src = ../..;
  };

  # The Hackage index-state from cabal.project
  index-state =
    parseIndexState (builtins.readFile ../../cabal.project);

  sha256map = import ./sha256map.nix;

  plan-sha256 = builtins.readFile ./plan-sha256;
  materialized = ./materialized;

  modules = [
    {
      packages = {
        # Broken due to haddock errors. Refer to https://github.com/input-output-hk/plutus/blob/master/nix/pkgs/haskell/haskell.nix
        plutus-ledger.doHaddock = false;
        plutus-use-cases.doHaddock = false;

        # See https://github.com/input-output-hk/iohk-nix/pull/488
        cardano-crypto-praos.components.library.pkgconfig = lib.mkForce [ [ libsodium-vrf ] ];
        cardano-crypto-class.components.library.pkgconfig = lib.mkForce [ [ libsodium-vrf ] ];
      };
    }
  ];
}

