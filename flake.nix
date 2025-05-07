{
  description = "Various Development Environments";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };
  outputs = {
    flake-utils,
    nixpkgs,
    fenix,
    nixpkgs-python,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        rust = import ./shells/rust.nix {inherit system nixpkgs fenix;};
        python = import ./shells/python.nix {inherit system nixpkgs nixpkgs-python;};
        latex = import ./shells/LaTeX.nix {inherit system nixpkgs;};
        haskell = import ./shells/haskell.nix {inherit system nixpkgs;};
        c = import ./shells/cpp.nix {inherit system nixpkgs;};
      };
    });
}
