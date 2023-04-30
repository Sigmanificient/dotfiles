{ unstable }:
{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ../../config/bpytop
      ../../config/neofetch
      ../../config/picom
      ../../config/qtile
      ../../config/dunst
      ../../config/firefox
      ../../config/zsh

      ../../config/betterlockscreen.nix
      ../../config/extra_files.nix
      ../../config/flameshot.nix
      ../../config/git.nix
      ../../config/gtk.nix
      ../../config/kitty.nix
      ../../config/profile.nix
    ];

  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = pkgs.nano;
    };

    packages = with pkgs; [
      # settings
      arandr
      brightnessctl
      lxappearance

      # volume
      pamixer
      pulsemixer
      pavucontrol

      # messaging
      discord
      unstable.discord-canary
      tdesktop

      # dev
      gnumake
      insomnia
      unstable.jetbrains.jdk
      unstable.jetbrains.clion
      jetbrains.pycharm-professional
      jetbrains.webstorm
      neovim
      sublime4
      tokei
      wakatime

      # minecraft
      minecraft
      prismlauncher

      # misc
      gimp
      neofetch
      obsidian

      # utils
      bpytop
      peek
      ripgrep
      dconf
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

    feh.enable = true;
    lazygit.enable = true;
  };
}
