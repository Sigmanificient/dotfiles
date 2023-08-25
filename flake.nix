{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";

    dotfiles.url = "github:Sigmanificient/dotfiles";
    dotfiles.inputs.qtile.follows = "/";
  };

  outputs = { self, nixpkgs, dotfiles, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        py = pkgs.python311;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with py.pkgs; [
            black
            isort
            qtile
          ] ++ [ pkgs.kitty pkgs.jgmenu ];
        };

        formatter = pkgs.nixpkgs-fmt;
        packages = rec {
          qtile-reset = (pkgs.writeShellScriptBin "qtile-reset" ''
            find ~/.config/qtile -type d -name "__pycache__" | xargs rm -rf {} +
            pkill -SIGUSR1 .qtile-wrapped
          '');

          qtile-test = let
            pkgbin = pkg: bin: "${pkg}/bin/${bin}";
          in
          let
            repo = ./.;
            qtile = pkgbin pkgs.qtile "qtile";
            xephyr = pkgbin pkgs.xorg.xorgserver "Xephyr";
            picom = pkgbin pkgs.picom "picom";
          in (pkgs.writeShellScriptBin "qtile-test" ''
            echo "Starting Xephyr"
            ${xephyr} -br -ac -noreset -screen 1600x900 :1 &
            sleep 1

            echo "Starting Qtile"
            DISPLAY=:1 ${qtile} start -b x11 --config ${repo}/src/config.py &
            sleep 1

            echo "Starting Picom"
            DISPLAY=:1 ${picom} --config ${dotfiles}/home/picom/picom.conf
          '');

          default = qtile-reset;
        };
      });
}
