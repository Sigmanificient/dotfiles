{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [ ./hardware-configuration.nix ];
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "BaconServer";
    firewall.enable = false;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      bat bpytop git htop kitty neofetch nano ripgrep tree vim wakatime wget
    ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };

  services = {
    xserver.enable = false;
    openssh.enable = true;

    minecraft-server = {
      enable = true;
      eula = true;

      declarative = true;

      serverProperties = {
        server-port = 3301;
        difficulty = 3;
        gamemode = 0;
        max-players = 5;
        motd = "NixOS Minecraft server!";
        enable-rcon = true;
        "rcon.password" = "op";
      };
    };
  };

  users.users.bacon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "22.11";
}
