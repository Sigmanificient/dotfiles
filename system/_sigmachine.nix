{ pkgs, lib, ... }: {
  boot.loader.grub.gfxmodeEfi = lib.mkForce "1920x1200x32";

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };
  hardware.graphics = {
    enable = true;

      extraPackages = with pkgs; [
        amdvlk
        intel-media-driver
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiIntel
        vaapiVdpau
        vulkan-validation-layers
        mesa.drivers
      ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true; # install `nvidia-offload`

      intelBusId = "PCI:0:02:0";
      nvidiaBusId = "PCI:3:0:0";
    };
  };

}
