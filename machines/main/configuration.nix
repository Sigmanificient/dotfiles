{ unstable }:
{ config, pkgs, ... }:
{
  imports =
    [
      ../../config/polkit.nix
      ../../config/issue
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = [ "amdgpu" ];
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

  hardware.cpu.amd.updateMicrocode = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
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
    hostName = "Sigmachine";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  sound.enable = true;
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
      displayManager.startx.enable = true;
      layout = "fr";
      libinput.enable = true;
      windowManager.qtile.enable = true;
    };
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

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
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
    ];
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };
}
