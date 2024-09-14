{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        amdvlk
        intel-media-driver
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiIntel
        vaapiVdpau
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
