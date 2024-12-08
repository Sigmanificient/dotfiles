{ lib, ... }: {
  boot.loader.grub.gfxmodeEfi = lib.mkForce "1920x1200x32";

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };
}
