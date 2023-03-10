{ unstable }:
{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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
    windowManager.qtile.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh.custom = "$HOME/extra/zsh";
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      "git"
      "ssh-agent"
      "wakatime"
      "zsh-autocomplete"
      "zsh-syntax-highlighting"
      "zsh-wakatime"
    ];
    ohMyZsh.theme = "sigma";
  };

  environment.shells = with pkgs; [ zsh ];

  programs.command-not-found.enable = false;
  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.thunar.enable = true;

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
      direnv
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

  environment.systemPackages = with pkgs; [
    unstable.catppuccin-papirus-folders
    catppuccin-cursors
    catppuccin-gtk
    git
    htop
    tree
    vim
    vifm
    wget
  ];

  environment.etc.issue.text = (builtins.readFile ../../extra/issue);

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.picom = {
     enable = true;
     fade = true;
  };

  services.openssh.enable = true;
  system.copySystemConfiguration = false;
  system.stateVersion = "22.11";
}
