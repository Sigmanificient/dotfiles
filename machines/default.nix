{ home-manager, hosts, nixos-hardware, nixpkgs, system, unstable, ... }:
{
  BaconServer = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      ./server/hardware-configuration.nix
      ./server/configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.users.bacon = import ./server/home.nix;
      }
    ];
  };

  Sigmachine = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      # Harware
      ./main/hardware-configuration.nix
      nixos-hardware.nixosModules.asus-battery
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd

      # System
      (import ./main/configuration.nix { inherit unstable; })
      hosts.nixosModule
      {
        networking.stevenBlackHosts.enable = true;
      }

      # Home
      home-manager.nixosModules.home-manager
      {
        home-manager.users.sigmanificient =
          (import ./main/home.nix { inherit unstable; });
      }
    ];
  };
}
