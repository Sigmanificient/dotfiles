{ config, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/2c4e0428-4dbb-4e7d-a2ba-27dfc7f72762";
      fsType = "ext4";
    };

    "/data" = {
      device = "/dev/disk/by-uuid/58799c4d-2c8c-4f26-8ee4-1c8ceb796705";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/6838-4F6B";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/41b9c6d5-5ac9-4549-b510-8249ec7c3be8"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
