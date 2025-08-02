{ pkgs, username, osConfig, spicePkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "blue";
  };

  imports = [
    ./nvim

    ./bash
    ./btop
    ./neofetch
    ./picom
    ./dunst
    ./qtile
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

  xdg.configFile."xkb/symbols/us_qwerty-fr".source =
    "${pkgs.callPackage ./../system/qwerty-fr.nix {}}"
    + "/usr/share/X11/xkb/symbols/us_qwerty-fr";
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    keyboard = null; # using custom layout

    stateVersion = "22.11";
    sessionVariables.EDITOR = "nvim";

    packages = with pkgs; [
      # settings
      arandr
      brightnessctl
      python3Packages.iwlib

      # messaging
      discord
      floorp
      teams-for-linux

      # dev
      nix-output-monitor
      gnumake
      lazygit
      tokei
      wakatime

      # misc
    ] ++ (if osConfig.services.pipewire.enable then [
      pamixer
      pavucontrol
    ] else [ ]) ++ [
      gimp
      neofetch
      pass

      # utils
      peek
      ripgrep
      dconf
      zip
      unzip
    ];
  };

  manual.manpages.enable = false;
  programs = {
    dircolors.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    feh.enable = true;
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = [
      spicePkgs.extensions.fullAppDisplay
      spicePkgs.extensions.hidePodcasts
      spicePkgs.extensions.playNext
      spicePkgs.extensions.adblock
      spicePkgs.extensions.wikify
    ];
  };
}
