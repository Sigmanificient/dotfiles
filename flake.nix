{
  description = "Sigmachine configuration & dotfiles";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
      hosts.url = github:StevenBlack/hosts;
      nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, nixpkgs-unstable, hosts, ... }@inputs:
  let
      system = "x86_64-linux";
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.Sigmachine = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./.config/nixos/hardware-configuration.nix
        (import ./.config/nixos/configuration.nix { inherit unstable; })
        nixos-hardware.nixosModules.asus-battery
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        hosts.nixosModule {
          networking.stevenBlackHosts.enable = true;
        }
      ];
    };
  };
}
