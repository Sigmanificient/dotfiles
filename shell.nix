{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.mkShell {
  name = "Nix dotfiles";
  description = "Utils for my dotfiles.";

  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
  ];
}
