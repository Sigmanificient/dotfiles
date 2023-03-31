{ config, pkgs, ... }:
{
  home.username = "sigmanificient";
  home.homeDirectory = "/home/sigmanificient";

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
