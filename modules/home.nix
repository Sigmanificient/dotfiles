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
    ];
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

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
