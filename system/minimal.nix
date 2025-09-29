{ pkgs, username, ... }:
{
  boot.loader.grub.device = "nodev";

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;
}
