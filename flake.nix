{
  description = "A very basic flake";

  inputs = {
    cabal-extras = {
      type = "github";
      owner = "phadej";
      repo = "cabal-extras";
      flake = false;
    };

    cabal-fmt = {
      type = "github";
      owner = "phadej";
      repo = "cabal-fmt";
      flake = false;
    };

    ekg-json = {
      type = "github";
      owner = "pepeiborra";
      repo = "ekg-json";
      rev = "7a0af7a8fd38045fd15fb13445bdcc7085325460";
      flake = false;
    };

    eventlog2html = {
      type = "github";
      owner = "mpickering";
      repo = "eventlog2html";
      flake = false;
    };

    gentle-introduction = {
      type = "github";
      owner = "phadej";
      repo = "gentle-introduction";
      rev = "949a99b4d2d8c556bdd455f0e4c4d94f0402ea63";
      flake = false;
    };

    ghcid = {
      type = "github";
      owner = "ndmitchell";
      repo = "ghcid";
      flake = false;
    };

    haskell-language-server = {
      type = "github";
      owner = "haskell";
      repo = "haskell-language-server";
      flake = false;
    };

    haskell-nix = {
      type = "github";
      owner = "input-output-hk";
      repo = "haskell.nix";
    };

    hindent = {
      type = "github";
      owner = "mihaimaruseac";
      repo = "hindent";
      flake = false;
    };

    hooglite = {
      type = "github";
      owner = "phadej";
      repo = "hooglite";
      rev = "18856375932f6744cac7849bd1e816538537863f";
      flake = false;
    };

    pointfree = {
      type = "github";
      owner = "bmillwood";
      repo = "pointfree";
      flake = false;
    };

    warp-wo-x509 = {
      type = "github";
      owner = "phadej";
      repo = "warp-wo-x509";
      rev = "98648f7520d228e6a14747223f0bbd68620b9318";
      flake = false;
    };

    weeder = {
      type = "github";
      owner = "ocharles";
      repo = "weeder";
      flake = false;
    };
  };

  outputs =
    { self
    , cabal-extras
    , cabal-fmt
    , ekg-json
    , eventlog2html
    , gentle-introduction
    , ghcid
    , haskell-language-server
    , haskell-nix
    , hindent
    , hooglite
    , pointfree
    , warp-wo-x509
    , weeder
    ,
    }:
    haskell-nix.inputs.flake-utils.lib.eachSystem [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ]
      (system:
      let
        ce = pkgs.callPackage project/cabal-extras.nix {
          inherit compiler-nix-name index-state self;
        };
        cabal-fmt = pkgs.callPackage project/cabal-fmt.nix {
          inherit compiler-nix-name index-state self;
        };
        compiler-nix-name = "ghc923";
        eventlog2html = pkgs.callPackage project/eventlog2html.nix {
          inherit compiler-nix-name index-state self;
        };
        ghcid = pkgs.callPackage project/ghcid.nix {
          inherit compiler-nix-name index-state self;
        };
        index-state = hls.index-state;
        hls =
          pkgs.callPackage project/hls.nix { inherit compiler-nix-name self; };
        hindent = pkgs.callPackage project/hindent.nix {
          inherit compiler-nix-name index-state self;
        };
        pointfree = pkgs.callPackage project/pointfree.nix {
          inherit compiler-nix-name index-state self;
        };
        weeder = pkgs.callPackage project/weeder.nix {
          inherit compiler-nix-name index-state self;
        };
        pkgs = import haskell-nix.inputs.nixpkgs-unstable {
          inherit system;
          config = haskell-nix.config;
          overlays = [ haskell-nix.overlay ];
        };
        default = pkgs.symlinkJoin {
          name = "haskell-nix-utils";
          paths = [
            pkgs.haskell-nix.cabal-install."${compiler-nix-name}"
            pkgs.haskell-nix.nix-tools."${compiler-nix-name}"
            ce.cabal-bundler.components.exes.cabal-bundler
            ce.cabal-deps.components.exes.cabal-deps
            ce.cabal-diff.components.exes.cabal-diff
            ce.cabal-docspec.components.exes.cabal-docspec
            ce.cabal-env.components.exes.cabal-env
            ce.cabal-hie.components.exes.cabal-hie
            ce.cabal-store-check.components.exes.cabal-store-check
            ce.cabal-store-gc.components.exes.cabal-store-gc
            cabal-fmt.cabal-fmt.components.exes.cabal-fmt
            eventlog2html.eventlog2html.components.exes.eventlog2html
            ghcid.ghcid.components.exes.ghcid
            hindent.hindent.components.exes.hindent
            hls.aeson-pretty.components.exes.aeson-pretty
            hls.alex.components.exes.alex
            hls.apply-refact.components.exes.refactor
            hls.cpphs.components.exes.cpphs
            hls.floskell.components.exes.floskell
            hls.fourmolu.components.exes.fourmolu
            hls.happy.components.exes.happy
            hls.haskell-language-server.components.exes.haskell-language-server
            hls.hiedb.components.exes.hiedb
            hls.hlint.components.exes.hlint
            hls.hp2pretty.components.exes.hp2pretty
            hls.hscolour.components.exes.HsColour
            hls.ormolu.components.exes.ormolu
            hls.pretty-simple.components.exes.pretty-simple
            hls.retrie.components.exes.retrie
            hls.stylish-haskell.components.exes.stylish-haskell
            pointfree.pointfree.components.exes.pointfree
            weeder.weeder.components.exes.weeder
          ];
        };
      in
      {
        packages = {
          inherit default;
          inherit pkgs compiler-nix-name index-state;
        };
      });
}
