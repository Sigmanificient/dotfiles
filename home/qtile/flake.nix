{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      py = pkgs.python311;
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with py.pkgs; [
          black
          isort
          qtile
        ];
      };

      formatter = pkgs.nixpkgs-fmt;
      packages = rec {
        qtile-reset =  (pkgs.writeShellScriptBin "qtile-reset" ''
          find ~/.config/qtile -type d -name "__pycache__" | xargs rm -rf {} +
          pkill -SIGUSR1 .qtile-wrapped
        '');

        default = qtile-reset;
      };
    });
}
