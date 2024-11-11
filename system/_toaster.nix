{ lib, ... }: {
  programs = {
    noisetorch.enable = lib.mkForce false;
    steam.enable = lib.mkForce false;
  };

  services.pipewire = {
    enable = lib.mkForce false;
    alsa.enable = lib.mkForce false;
    alsa.support32Bit = lib.mkForce false;
    pulse.enable = lib.mkForce false;
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
