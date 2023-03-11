{ unstable }:
{ config, pkgs, ... }:
{
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

  hardware.nvidia.prime = {
    offload.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:6:0:0";
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  environment.pathsToLink = [ "/share/nix-direnv" ];
  nixpkgs.overlays = [
    (self: super: { 
      nix-direnv = super.nix-direnv.override {
        enableFlakes = true; 
      };
    })
  ];

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

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    layout = "fr";
    libinput.enable = true;
    videoDrivers = [ "nvidia" ];
    windowManager.qtile.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      custom = "$HOME/extra/zsh";
      plugins = [
        "git"
        "ssh-agent"
        "wakatime"
        "zsh-autocomplete"
        "zsh-syntax-highlighting"
        "zsh-wakatime"
      ];
      theme = "sigma";
    };
  };

  programs.command-not-found.enable = false;
  programs.thunar.enable = true;

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  users.users.sigmanificient = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
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
      pamixer
      pavucontrol
      peek
      rofi
      sublime4
      tdesktop
      tokei
      wakatime
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

  environment.etc.issue.text = (builtins.readFile ../../extra/issue);
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    unstable.catppuccin-papirus-folders
    catppuccin-cursors
    catppuccin-gtk
    direnv 
    nix-direnv
    git
    htop
    tree
    vim
    vifm
    wget
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.picom = {
     enable = true;
     fade = true;
  };

  system.copySystemConfiguration = false;
  system.stateVersion = "22.11";
}
