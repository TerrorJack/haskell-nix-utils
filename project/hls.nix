{ compiler-nix-name, haskell-nix, self, }:
haskell-nix.cabalProject {
  src = self.inputs.haskell-language-server;
  inherit compiler-nix-name;
  inputMap = {
    "https://github.com/pepeiborra/ekg-json" = self.inputs.ekg-json;
  };
  modules = [
    { packages.ghc-check.flags = { ghc-check-use-package-abis = false; }; }
    {
      packages.haskell-language-server.patches =
        [ ../patch/haskell-language-server.diff ];
    }
  ];
}
