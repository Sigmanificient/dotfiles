{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    ecsls.url = "github:Sigmapitech-meta/ecsls";

    qtile.url = "github:Sigmanificient/QtileConfig";
    qtile.inputs.dotfiles.follows = "/";

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
    , qtile
    , ...
    }:
    let
      username = "sigmanificient";
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

      default_modules = [
        nix-index-database.nixosModules.nix-index

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = {
            inherit ecsls qtile;
            conf = {
              inherit username;
              inherit system;
              ecsls.enable = true;
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

          modules = default_modules ++ [
            (import ./config { hostname = "Bacon"; })
            ./hardware/bacon.nix

            nixos-hardware.nixosModules.asus-battery
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
          ];
        };

        Sigmachine = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = default_modules ++ [
            (import ./config { hostname = "Sigmachine"; })
            ./hardware/sigmachine.nix
            # ./config/github_runner.nix
          ];
        };
      };
    };
}
