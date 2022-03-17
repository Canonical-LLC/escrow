{ lib }:

{
  parseIndexState = rawCabalProject:
    let
      indexState = lib.lists.concatLists (
        lib.lists.filter (l: l != null)
          (map (builtins.match "^index-state: *(.*)")
            (lib.splitString "\n" rawCabalProject)));
    in
    lib.lists.head (indexState ++ [ null ]);
}
