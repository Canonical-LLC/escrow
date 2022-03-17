final:

let
  lib = final.callPackage ./lib.nix { };
  project = final.callPackage ./project.nix { inherit (lib) parseIndexState; };
in
_prev:
{
  canonical-escrow = {
    inherit lib project;

    # TODO add exes?
  };
}
