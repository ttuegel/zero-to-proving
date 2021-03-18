let
  sources = import ./nix/sources.nix {};

  pkgs = import sources."nixpkgs" { config = {}; overlays = []; };
  inherit (pkgs) mkShell;

  home = builtins.getEnv "HOME";
  kframework = import "${home}/kframework/k" {};

  inherit (kframework) k haskell-backend llvm-backend;
in

mkShell {
  buildInputs = [ k haskell-backend llvm-backend ];
}