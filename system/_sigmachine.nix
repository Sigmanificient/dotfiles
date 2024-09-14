{ config, pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];

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

  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

    xserver.videoDrivers = [ "nvidia" ];
    upower.enable = true;
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };
}
