{ system ? builtins.currentSystem
, self ? builtins.getFlake (toString ./.)
, packages ? self.outputs.packages."${system}"
, default ? packages.default
, pkgs ? packages.pkgs
, compiler-nix-name ? packages.compiler-nix-name
, index-state ? packages.index-state
, buildDepends ? ""
, cabalSrc ? ''
    cabal-version: >= 1.2
    name: asdf
    version: 0
    build-type: Simple

    library
      build-depends: ${buildDepends}
  ''
, configureArgs ? "--allow-newer=all:base --minimize-conflict-set"
, src ? pkgs.writeTextDir "asdf.cabal" cabalSrc
, project ? pkgs.haskell-nix.cabalProject {
    inherit src;
    inherit compiler-nix-name index-state configureArgs;
  }
, shell ? project.shellFor {
    nativeBuildInputs = [ default ];
    tools = { hoogle = { inherit index-state; }; };
    withHoogle = true;
    exactDeps = true;
  }
,
}:
shell
