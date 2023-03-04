{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
  };

  networking.hostName = "Sigmachine";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
      libinput.enable = true;
      layout = "fr";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.command-not-found.enable = false;
  virtualisation.docker.enable = true;

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  users.users.sigmanificient = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [
      (pkgs.callPackage packages/APL385Mono.nix { })
      bat
      betterlockscreen
      bpytop
      dunst
      discord
      feh
      firefox-devedition-bin
      flameshot
      gimp
      insomnia
      jetbrains.clion
      jetbrains.pycharm-professional
      kitty
      lazygit
      lxappearance
      gnumake
      neofetch
      obsidian
      oh-my-zsh
      pamixer
      pavucontrol
      peek
      picom
      qtile
      rofi
      sublime4
      tdesktop
      xfce.thunar
      tokei
      unstable.catppuccin-papirus-folders
      wakatime
      zsh
    ];
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

  environment.systemPackages = with pkgs; [
    catppuccin-cursors
    catppuccin-gtk
    git
    htop
    tree
    vim
    vifm
    wget
  ];

  environment.etc.issue.text = ''
    [1;32m<<< Welcome to NixOS - \l >>>[0m

        77777777777777           77777            7777777777777
      777777 77777 7777777777   77777777    7777777777777  7  777
      777777  77 77777777777777777777777777777 777777777  7777777
        77777777 7777 77777777777777  777777777777777777 7777777
           777777777777777  7  77777777 7 7777777777777777777
             77777 77777        7777 77        777777 7777
                  7777777       777777         77 7777
                  77777         77 7 7         77 7777
                  7777777777    77 7 7 77    77777777
                     777        77777    7  777
                                 777
                                  77
                                   77

  '';

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "22.11";
}
