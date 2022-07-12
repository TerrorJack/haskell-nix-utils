{ applyPatches, compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  src = applyPatches {
    name = "cabal-extras-src";
    src = self.inputs.cabal-extras;
    patches = [ ../patch/cabal-extras.diff ];
  };
  inherit compiler-nix-name index-state;
  cabalProjectLocal = ''
    allow-newer: *:base, *:bytestring, *:ghc-prim, *:time, *:template-haskell, *:unix
  '';
  inputMap = {
    "https://github.com/phadej/gentle-introduction.git" =
      self.inputs.gentle-introduction;
    "https://github.com/phadej/warp-wo-x509.git" = self.inputs.warp-wo-x509;
    "https://github.com/phadej/hooglite.git" = self.inputs.hooglite;
  };
}
