{ username, hostname, pkgs, ... }:
{
  imports =
    [
      ./polkit.nix
    ];

  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      kernelModules = [ "amdgpu" ];
    };

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080x32";
      };
    };
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 90d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
    };
    optimise.automatic = true;
  };

  environment.pathsToLink = [ "/share/nix-direnv" ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    useXkbConfig = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "11111E" # Black
      "E12541" # red
      "14C67B" # green
      "FFAC7D" # yellow
      "7270FF" # blue
      "FD8DFF" # magenta
      "75DFED" # cyan
      "A4B1E3" # white

      "474B77" # light black
      "DE6876" # light red
      "63D961" # light green
      "FFDA8D" # light yellow
      "AAA9FA" # light blue
      "E5A5FB" # light magenta
      "BEEDF8" # light cyan
      "DBE2FB" # light white
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
  };

  programs = {
    command-not-found.enable = false;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    zsh.enable = true;
    noisetorch.enable = true;
  };

  security.rtkit.enable = true;
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    gvfs.enable = true;
    tumbler.enable = true;
    openssh.enable = true;

    picom = {
      enable = true;
      fade = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      layout = "fr";
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
      };
      windowManager.qtile = {
        enable = true;
        backend = "x11";
      };
    };

    upower.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "audio" "docker" "networkmanager" "libvirtd" "wheel" ];
    initialPassword = "hello";
  };

  fonts.packages = with pkgs; let
    jetbrains-mono-nerd-font = (nerdfonts.override
      { fonts = [ "JetBrainsMono" ]; });
  in
  [
    jetbrains-mono-nerd-font
    dina-font
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    apl386
  ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  documentation.dev.enable = true;
  environment = {
    etc.issue.text = (builtins.readFile ./issuerc);
    sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    shells = [ pkgs.zsh ];
    systemPackages = with pkgs; [
      alsa-utils
      modemmanager
      networkmanagerapplet
      libsForQt5.ark
      libsForQt5.plasma-nm
      playerctl

      git
      htop
      tree
      vim
      vifm
      wget

      libnotify
      virt-manager

      man-pages
      man-pages-posix

      zip
      unzip
    ];
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };

  qt.style = "adwaita-dark";
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-kde
    ];
  };
}
