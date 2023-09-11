{ pkgs, conf, ecsls, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ./nvim { inherit ecsls pkgs conf; })

    ./bash
    ./btop
    ./neofetch
    ./picom
    ./dunst
    ./firefox
    ./qtile
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
    username = "${conf.username}";
    homeDirectory = "/home/${conf.username}";

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
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })

      teams
      tdesktop

      # dev
      gnumake
      tokei
      wakatime

      # misc
      spotify
      gimp
      neofetch
      obsidian
      pass

      # utils
      jgmenu
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
