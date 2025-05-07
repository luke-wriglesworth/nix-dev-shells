{
  nixpkgs,
  nixpkgs-python,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  python = pkgs.python313Full;
  pythonPkgs = pkgs.python313Packages;
in
  pkgs.mkShell {
    name = "python-venv";
    venvDir = "./.venv";
    nativeBuildInputs = [pkgs.undetected-chromedriver pkgs.google-chrome];
    buildInputs = [
      python
      pkgs.nodejs
      pythonPkgs.ipykernel
      pythonPkgs.numpy
      pythonPkgs.beautifulsoup4
      pythonPkgs.pandas
      pythonPkgs.requests
      pythonPkgs.openpyxl
      pythonPkgs.selenium
      pythonPkgs.webdriver-manager
      pythonPkgs.undetected-chromedriver
      pythonPkgs.openai
    ];
  }
