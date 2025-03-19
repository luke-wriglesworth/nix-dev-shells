{
  nixpkgs,
  system,
  fenix,
}: let
  pkgs = import nixpkgs {inherit system;};
in
  pkgs.mkShell {
    name = "rust";
    buildInputs = [fenix.packages.${system}.latest.toolchain];
    shellHook = ''
      export CARGO_HOME="$PWD/.cargo"
      export PATH="$CARGO_HOME/bin:$PATH"
    '';
  }
