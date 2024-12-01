{ config, pkgs, ... }: {
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

    upower.enable = true;
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };
}
