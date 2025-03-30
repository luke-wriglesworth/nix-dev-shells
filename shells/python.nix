{
  nixpkgs,
  system,
  ...
}: let
  pkgs = import nixpkgs {
    inherit system;
    #config.replaceStdenv = {pkgs, ...}: pkgs.fastStdenv;
  };
  pythonFast = pkgs.python313Full.override {
    enableOptimizations = true;
    enableLTO = true;
    reproducibleBuild = false;
  };
  lib-path = with pkgs;
    lib.makeLibraryPath [
      fastStdenv.cc.cc
    ];
in
  pkgs.mkShell {
    name = "python-venv";
    venvDir = "./.venv";
    packages = [
      pythonFast
      pkgs.nodejs
      pkgs.uv
    ];
    shellHook = ''
      SOURCE_DATE_EPOCH=$(date +%s)
      export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
      VENV=.venv

      if test ! -d $VENV; then
        python3 -m venv $VENV
      fi
      source ./$VENV/bin/activate
      export PYTHONPATH=`pwd`/$VENV/${pythonFast.sitePackages}/:$PYTHONPATH
      uv pip install matplotlib scipy numpy pandas ipykernel tqdm
    '';

    postShellHook = ''
      ln -sf ${pythonFast.sitePackages}/* ./.venv/lib/python3.13/site-packages
    '';
    NIX_ENFORCE_NO_NATIVE = false;
  }
