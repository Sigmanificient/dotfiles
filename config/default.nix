{ hostname }:
{ config, pkgs, ... }:
{
  imports =
    [
      ./issue
      ./polkit.nix
    ];

  boot = {
    consoleLogLevel = 3;
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
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  environment.pathsToLink = [ "/share/nix-direnv" ];
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (_: super: {
        nix-direnv = super.nix-direnv.override {
          enableFlakes = true;
        };
      })
    ];
  };

  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    useXkbConfig = true;
    font = "Lat2-Terminus16";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "0e0e18" # Black
      "d22942" # red
      "17b67c" # green
      "f2a174" # yellow
      "8c8af1" # blue
      "d78af1" # magenta
      "8adef1" # cyan
      "c9d3f9" # white

      "1a1c31" # light black
      "de4259" # light red
      "3fd7a0" # light green
      "eed49f" # light yellow
      "a7a5fb" # light blue
      "e5a5fb" # light magenta
      "a5ebfb" # light cyan
      "cad3f5" # light white
    ];
  };

  hardware.pulseaudio.enable = false;

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
      excludePackages = with pkgs; [ xterm ];
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
        extraPackages = python3Packages: with python3Packages; [
          qtile-extras
        ];
      };
    };

    upower.enable = true;
  };

  users.users.sigmanificient = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "docker" "networkmanager" "libvirtd" "wheel" ];
    initialPassword = "hello";
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    dina-font
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
  ];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  documentation.dev.enable = true;
  environment = {
    sessionVariables.MOZ_USE_XINPUT2 = "1";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      alsa-utils
      modemmanager
      networkmanagerapplet
      libsForQt5.ark
      libsForQt5.plasma-nm

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

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  qt.style = "adwaita-dark";
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Make sure opengl is enabled
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
