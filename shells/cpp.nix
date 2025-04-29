{
  nixpkgs,
  system,
}: let
  pkgs = import nixpkgs {inherit system;};
in
  pkgs.mkShell.override {
    stdenv = pkgs.fastStdenv;
  } {
    buildInputs = [pkgs.llvmPackages.openmp];
  }
