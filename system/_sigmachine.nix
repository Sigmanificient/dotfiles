{ pkgs, lib, ... }: {
  boot.loader.grub.gfxmodeEfi = lib.mkForce "1920x1200x32";

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.05";
  };

  virtualisation.docker.enable = true;

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
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;

    nvidiaSettings = true;
    prime = {
      reverseSync.enable = true;
      allowExternalGpu = false;

     intelBusId = "PCI:0:02:0";
     nvidiaBusId = "PCI:3:0:0";
    };

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true; # install `nvidia-offload`
    };
  };

  services.sshd.enable = true;
  programs.ladybird.enable = true;

} // {
  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 0;

      START_CHARGE_THRESH_BAT0 = 30;
      STOP_CHARGE_THRESH_BAT0 = 70;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      TPSMAPI_ENABLE = 1;
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
