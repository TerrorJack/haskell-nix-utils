{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "cabal-fmt";
  src = self.inputs.cabal-fmt;
  inherit compiler-nix-name index-state;
  configureArgs = "--allow-newer=all:base";
}
