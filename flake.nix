{
  description = "Various Development Environments";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fenix.url = "github:nix-community/fenix";
  };
  outputs = {
    flake-utils,
    nixpkgs,
    fenix,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        rust = import ./shells/rust.nix {inherit system nixpkgs fenix;};
        python = import ./shells/python.nix {inherit system nixpkgs;};
        latex = import ./shells/LaTeX.nix {inherit system nixpkgs;};
      };
    });
}
