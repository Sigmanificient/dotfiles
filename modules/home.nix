{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  editorconfig.enable = true;
  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";

    packages = with pkgs; [
      arandr
      brightnessctl
      bpytop
      discord
      gimp
      insomnia
      jetbrains.clion
      jetbrains.pycharm-professional
      kitty
      lxappearance
      gnumake
      neofetch
      obsidian
      pamixer
      pulsemixer
      pavucontrol
      peek
      ripgrep
      sublime4
      tdesktop
      tokei
      wakatime
    ];
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    feh.enable = true;

    firefox = {
      enable = true;
      package = pkgs.firefox-devedition-bin;
    };

    lazygit.enable = true;
    git = import ./components/git.nix {};
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
