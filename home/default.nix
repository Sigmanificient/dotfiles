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

    packages =
      let
        figma-linux-wrap = pkgs.figma-linux.overrideAttrs (prev: {
          nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.wrapGAppsHook ];
        });

      in
      with pkgs; [
        # settings
        arandr
        brightnessctl

        # volume
        pavucontrol

        # messaging
        discord
        teams-for-linux

        # dev
        gnumake
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
      ];
  };

  manual.manpages.enable = false;
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
