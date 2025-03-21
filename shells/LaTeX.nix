{
  nixpkgs,
  system,
}: let
  pkgs = import nixpkgs {inherit system;};
in
  pkgs.mkShell {
    name = "LaTeX";
    buildInputs = [pkgs.texlive.combined.scheme-full];
  }
