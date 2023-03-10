{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.hosts.url = github:StevenBlack/hosts;

  description = "Sigmachine configuration & dotfiles";

  outputs = { self, nixpkgs, nixpkgs-unstable, hosts, ... }@inputs:
  let
      system = "x86_64-linux";
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.Sigmachine = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./.config/nixos/hardware-configuration.nix
        (import ./.config/nixos/configuration.nix { inherit unstable; })
        hosts.nixosModule {
          networking.stevenBlackHosts.enable = true;
        }
      ];
    };
  };
}
