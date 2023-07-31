{ config, pkgs, username, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./btop
    ./neofetch
    ./nvim
    ./picom
    ./qtile
    ./dunst
    ./firefox
    ./thunar
    ./tmux
    ./zsh

    ./betterlockscreen
    ./cursor.nix
    ./extra_files.nix
    ./flameshot.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

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
      discord-canary
      teams
      tdesktop

      # dev
      android-studio
      gnumake
      insomnia
      jetbrains.jdk
      jetbrains.clion
      jetbrains.pycharm-professional
      jetbrains.webstorm
      tokei
      wakatime

      # minecraft
      minecraft
      prismlauncher

      # misc
      gimp
      neofetch
      obsidian
      pass

      # utils
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
