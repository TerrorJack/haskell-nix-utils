{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "weeder";
  src = self.inputs.weeder;
  inherit compiler-nix-name index-state;
}
