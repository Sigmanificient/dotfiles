{ hostname }:
{ config, pkgs, ... }:
{
  imports =
    [
      ./issue
      ./polkit.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
      (self: super: {
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
    font = "Lat2-Terminus16";
    useXkbConfig = true;
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
      libsForQt5.ark
      libsForQt5.plasma-nm
      modemmanager
      networkmanagerapplet
      git
      htop
      tree
      vim
      vifm
      wget
      virt-manager

      man-pages
      man-pages-posix
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
