{ config, ... }:
{
  hardware.nvidia = {
    open = false;
    modesetting.enable = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = false;
        enableOffloadCmd = false;
      };
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };

    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
