{
  nixpkgs,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    #config.replaceStdenv = {pkgs, ...}: pkgs.fastStdenv;
    config.allowUnfree = true;
  };
  pythonFast = pkgs.python313Full.override {
    enableOptimizations = true;
    enableLTO = true;
    reproducibleBuild = false;
  };
  pypkgs = pkgs.python313Packages;
in
  pkgs.mkShell {
    name = "python-venv";
    venvDir = "./.venv";
    nativeBuildInputs = [pkgs.undetected-chromedriver pkgs.google-chrome];
    buildInputs = [
      pythonFast
      pkgs.nodejs
      pypkgs.matplotlib
      pypkgs.ipykernel
      pypkgs.numpy
      pypkgs.beautifulsoup4
      pypkgs.pandas
      pypkgs.requests
      pypkgs.openpyxl
      pypkgs.selenium
      pypkgs.webdriver-manager
      pypkgs.undetected-chromedriver
      pypkgs.openai
    ];
  }
