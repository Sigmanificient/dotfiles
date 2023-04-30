{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.mkShell {
  name = "Nix dotilfes";
  description = "Utils for my dotfiles.";

  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
  ];
}
