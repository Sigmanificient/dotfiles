{ pkgs ? import <nixpkgs> { }, ... }:
let
  py = {
    env = pkgs.python311.withPackages (_: py.deps.all);
    pkgs = pkgs.python311Packages;

    deps = rec {
      prod = with py.pkgs; [ qtile qtile-extras ];
      dev = with py.pkgs; [ black isort vulture ];
      all = prod ++ dev;
    };
  };

in
pkgs.mkShell {
  name = "Nix dotfiles";
  description = "Utils for my dotfiles.";

  nativeBuildInputs = with pkgs; [ py.env deadnix ];
  shellHook = ''
    echo ${py.env}
  '';
}
