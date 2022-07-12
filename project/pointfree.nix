{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "pointfree";
  src = self.inputs.pointfree;
  inherit compiler-nix-name index-state;
  configureArgs = "--allow-newer=all:base";
}
