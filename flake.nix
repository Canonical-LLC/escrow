{
  description = "A Plutus flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    plutus-apps.url = "github:input-output-hk/plutus-apps/plutus-starter-devcontainer/v1.0.14";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { flake-utils, plutus-apps, pre-commit-hooks, ... }:
    flake-utils.lib.eachSystem (import ./supported-systems.nix)
      (system:
        let
          plutus = import plutus-apps { inherit system; };
          pkgs = plutus.pkgs.appendOverlays [
            (_: _: { inherit plutus; })

            (import ./nix/haskell)
          ];
          inherit (pkgs.canonical-escrow) project;

          flake = project.flake { };

          hsTools = project.tools (import ./nix/haskell/tools.nix { inherit (pkgs.canonical-escrow) lib; });

          pre-commit = pkgs.callPackage ./nix/pre-commit-hooks.nix { inherit pre-commit-hooks hsTools; };

          update-materialized = pkgs.writeShellScriptBin "update-materialized" ''
            set -euo pipefail

            ${project.plan-nix.passthru.calculateMaterializedSha} > nix/haskell/plan-sha256
            mkdir -p nix/haskell/materialized
            ${project.plan-nix.passthru.generateMaterialized} nix/haskell/materialized
          '';
        in
        pkgs.lib.recursiveUpdate flake {
          checks = {
            inherit (pre-commit) pre-commit-check;
          };

          # so `nix build` will build the exe
          # defaultPackage = flake.packages."canonical-escrow:exe:canonical-escrow";

          # so `nix run`  will run the exe
          defaultApp = {
            # type = "app";
            # program = "${flake.packages."canonical-escrow:exe:canonical-escrow"}/bin/canonical-escrow";
          };

          apps = {
            update-materialized = {
              type = "app";
              program = "${update-materialized}/bin/update-materialized";
            };

            format = {
              type = "app";
              program = "${pre-commit.format}/bin/format";
            };
          };

          devShell =
            flake.devShell.overrideAttrs (attrs: {
              inherit (pre-commit) shellHook;

              buildInputs = attrs.buildInputs ++ [
                update-materialized
                plutus.plutus-apps.haskell-language-server
              ] ++ pre-commit.shellBuildInputs;
            });

          legacyPackages = pkgs;
        }
      );
}
