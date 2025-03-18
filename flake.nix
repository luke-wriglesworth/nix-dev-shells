{
  description = "Various Development Environments";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    rust = {
      url = "path:./rust";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    python = {
      url = "path:./python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-utils,
    rust,
    python,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        rust = rust.devShells.${system}.default;
        python = python.devShells.${system}.default;
      };
    });
}
