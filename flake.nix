{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    ecsls.url = "github:Sigmapitech-meta/ecsls";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nix-index-database
    , nixos-hardware
    , home-manager
    , hosts
    , ecsls
    , ...
    }:
    let
      username = "sigmanificient";
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      default_modules = [
        ./config

        nix-index-database.nixosModules.nix-index

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home;
            extraSpecialArgs = {
              inherit username system ecsls;
            };
          };
        }

        hosts.nixosModule
        {
          networking.stevenBlackHosts.enable = true;
        }
      ];

    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        Bacon = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit username;
            hostname = "Bacon";
          };

          modules = default_modules ++ [
            ./hardware/bacon.nix
            ./config/bacon.nix

            nixos-hardware.nixosModules.asus-battery
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
          ];
        };
      };
    };
}
