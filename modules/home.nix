{ config, pkgs, ... }:
{
  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Sigmanificient";
      userEmail = "edhyjox" + "@" + "gmail.com";
    };
  };
}
