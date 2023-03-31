{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";

    packages = with pkgs; [
      arandr
      brightnessctl
      bpytop
      discord
      firefox-devedition-bin
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

  services = {
    betterlockscreen.enable = true;

    dunst = {
      enable = true;
      settings = {
        global = {
          alignment = "left";
          always_run_script = true;
          corner_radius = 4;
          font = "JetBrainsMono Nerd Font Mono 10";
          frame_color = "#8AADF4";
          frame_width = 2;
          horizontal_padding = 14;
          icon_path="-";
          indicate_hidden = "yes";
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
          padding = 8;
          separator_color = "frame";
          separator_height = 2;
          show_indicators = "yes";
          sticky_history = "no";
          vertical_alignment = "center";
          word_wrap = "yes";
        };

        urgency_low = {
          background = "#0D0D1680";
          foreground = "#8AADF4";
          timeout = 10;
        };

        urgency_normal = {
          background = "#0D0D1680";
          foreground = "#EED49F";
          timeout = 15;
        };

        urgency_critical = {
          background = "#0D0D1680";
          foreground = "#ED8796";
          timeout = 30;
        };
      };
    };

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
