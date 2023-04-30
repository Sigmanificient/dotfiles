{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ../../config/bpytop/bpytop.nix
      ../../config/neofetch/neofetch.nix
      ../../config/zsh/zsh.nix
      ../../config/profile.nix

      ../../config/git.nix
      ../../config/kitty.nix
    ];

  home = {
    username = "BaconServer";
    homeDirectory = "/home/BaconServer";

    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = pkgs.nano;
    };

    packages = with pkgs; [
      bat
      bpytop
      git
      htop
      kitty
      neofetch
      nano
      ripgrep
      tree
      vim
      wakatime
      wget
    ];
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    dircolors.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    lazygit.enable = true;
  };
}
