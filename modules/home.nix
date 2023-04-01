{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  editorconfig.enable = true;
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
      tdesktop

      # dev
      gnumake
      insomnia
      jetbrains.clion
      jetbrains.pycharm-professional
      sublime4
      tokei
      wakatime

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

  gtk = {
    enable = true;

    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;
    };
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
    git = import ./components/git.nix {};
    lazygit.enable = true;

    kitty = import ./components/kitty.nix {};

    firefox = {
      enable = true;
      package = pkgs.firefox-devedition-bin;
    };

    zsh = import ./components/zsh.nix {};
  };

  services = {
    betterlockscreen.enable = true;
    dunst = import ./components/dunst.nix { inherit pkgs; };

    flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "/home/sigmanificient/pictures/screenshots";
          uiColor = "#1435c7";
        };
      };
    };
  };
}
