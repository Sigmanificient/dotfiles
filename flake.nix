{
  description = "Sigmachine configuration & dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hosts.url = github:StevenBlack/hosts;
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , hosts
    , ...
    } @inputs:
    let
      system = "x86_64-linux";

      default_modules = [
        ./config
        ./hardware/sigma.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sigmanificient = import ./home;
        }

        hosts.nixosModule
        {
          networking.stevenBlackHosts.enable = true;
        }
      ];

    in
    {
      nixosConfigurations = {
        BaconServer = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = default_modules ++ [
            ./config/server
            ./hardware/bacon.nix
          ];
        };

        Sigmachine = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = default_modules ++ [
            nixos-hardware.nixosModules.asus-battery
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      };
    };
}
