{ pkgs, username, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./nvim

    ./bash
    ./btop
    ./neofetch
    ./picom
    ./dunst
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

  xdg.configFile."xkb/symbols/us_qwerty-fr".source =
    "${pkgs.callPackage ./../system/qwerty-fr.nix {}}"
    + "/usr/share/X11/xkb/symbols/us_qwerty-fr";
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    keyboard = null;

    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = "${pkgs.nano}/bin/nano";
    };

    packages = with pkgs; [
      # settings
      arandr
      brightnessctl

      # volume
      pavucontrol

      # messaging
      discord
      teams-for-linux
      floorp

      # dev
      gnumake
      lazygit
      tokei
      wakatime

      # misc
      spotify
      gimp
      neofetch
      pass

      # utils
      peek
      ripgrep
      dconf
      mtm # minimalistic multiplexer
    ];
  };

  manual.manpages.enable = false;
  programs = {
    home-manager.enable = true;
    tmux.enable = true;

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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
