{ unstable }:
{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./neofetch
    ./picom
    ./qtile
    ./dunst
    ./firefox
    ./thunar
    ./zsh

    ./betterlockscreen.nix
    ./extra_files.nix
    ./flameshot.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./profile.nix
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
      teams
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
      unstable.wakatime

      # minecraft
      minecraft
      prismlauncher

      # misc
      gimp
      neofetch
      obsidian

      # utils
      btop
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
