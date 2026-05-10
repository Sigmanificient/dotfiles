{ ... }:
{
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  imports = [
    ./fastfetch
    ./picom
    ./qtile
    ./zsh

    ./extra_files.nix
    ./kitty.nix
  ];
}
