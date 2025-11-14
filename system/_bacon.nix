{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        nvidia-vaapi-driver
        intel-vaapi-driver
        libva-vdpau-driver
        vulkan-validation-layers
      ];
    };

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };
}
