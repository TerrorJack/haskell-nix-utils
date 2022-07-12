{ compiler-nix-name, haskell-nix, index-state, self, }:
haskell-nix.cabalProject {
  name = "eventlog2html";
  src = self.inputs.eventlog2html;
  inherit compiler-nix-name index-state;
  cabalProjectLocal = ''
    allow-newer: *:aeson, *:base, *:hvega
  '';
}
