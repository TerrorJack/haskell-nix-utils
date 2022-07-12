{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "ghcid";
  src = self.inputs.ghcid;
  inherit compiler-nix-name index-state;
}
