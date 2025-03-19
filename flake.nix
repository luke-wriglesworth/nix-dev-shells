{
  description = "Various Development Environments";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    rust.url = "path:./rust";
    python.url = "path:./python";
  };

  outputs = {
    flake-utils,
    python,
    rust,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        rust = rust.devShells.${system}.default;
        python = python.devShells.${system}.default;
      };
    });
}
