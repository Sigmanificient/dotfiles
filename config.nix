# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  networking.hostName = "Sigmachine";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.layout = "fr";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.sigmanificient = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      pamixer
      sublime4
      qtile
      firefox-devedition-bin
      kitty
      bpytop
      dunst
      flameshot
      discord
      picom
      neofetch
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
      vim
      wget
      git
      htop
      nerdfonts
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "22.11";
}
