{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "hindent";
  src = self.inputs.hindent;
  inherit compiler-nix-name index-state;
  configureArgs = "--allow-newer='*:base' --constraint='Cabal == 3.4.1.0'";
}
