{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";

    packages = with pkgs; [
      arandr
      betterlockscreen
      brightnessctl
      bpytop
      dunst
      discord
      firefox-devedition-bin
      flameshot
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
      rofi
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
    lazygit.enable = true;

    git = {
      enable = true;
      userName = "Sigmanificient";
      userEmail = "edhyjox" + "@" + "gmail.com";

      extraConfig.url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };

      ignores = [
        # C commons
        "*.gc??"
        "vgcore.*"
        # Python
        "venv"
        # Locked Files
        "*~"
        # Mac folder
        ".DS_Store"
        # Direnv
        ".direnv"
        ".envrc"
        # IDE Folders
        ".idea"
        ".vscode"
        ".vs"
      ];
    };
  };
}
