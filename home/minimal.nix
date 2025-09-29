{ ... }:
{
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  imports = [
    ./picom
    ./qtile
    ./zsh

    ./extra_files.nix
    ./kitty.nix
  ];
}
