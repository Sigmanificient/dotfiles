{ lib, ... }: {
  programs = {
    noisetorch.enable = lib.mkForce false;
    steam.enable = lib.mkForce false;
  };

  services.upower.enable = true;

  virtualisation = {
    docker.enable = lib.mkForce false;
    libvirtd.enable = lib.mkForce false;
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };
}
