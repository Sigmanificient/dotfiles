{ config, pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    graphics = {
      enable = true;

      extraPackages = with pkgs; [
        amdvlk
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiVdpau
        vulkan-validation-layers
      ];
    };
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };
}
