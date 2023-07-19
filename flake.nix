{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    hosts.url = github:StevenBlack/hosts;
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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
      username = "sigmanificient";
      system = "x86_64-linux";

      default_modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = { inherit username; };
        }

        hosts.nixosModule
        {
          networking.stevenBlackHosts.enable = true;
        }
      ];

    in
    {
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
            ./config/github_runner.nix
          ];
        };
      };
    };
}
