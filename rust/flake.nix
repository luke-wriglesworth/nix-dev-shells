{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    flake-utils,
    fenix,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = let
        pkgs = import nixpkgs {inherit system;};
      in
        pkgs.mkShell {
          name = "rust";
          buildInputs = [fenix.packages.${system}.latest.toolchain];
          shellHook = ''
            export CARGO_HOME="$PWD/.cargo"
            export PATH="$CARGO_HOME/bin:$PATH"
          '';
        };
    });
}
