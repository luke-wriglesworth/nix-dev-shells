{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    flake-utils,
    fenix,
    nixpkgs,
    ...
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = pkgs.mkShell {
        name = "rust";
        buildInputs = [fenix.packages.x86_64-linux.latest.toolchain];
        shellHook = ''
          export CARGO_HOME="$PWD/.cargo"
          export PATH="$CARGO_HOME/bin:$PATH"
        '';
      };
    });
}
