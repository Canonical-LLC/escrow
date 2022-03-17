{ system ? builtins.currentSystem
}:

(builtins.getFlake (toString ./.)).legacyPackages.${system}.canonical-escrow.project
