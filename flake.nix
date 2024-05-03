{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    vera-clang = {
      url = "github:Sigmapitech/vera-clang";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    ecsls = {
      url = "github:Sigmapitech/ecsls";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
        # Cannot use nested vera-clang.inputs.nixpkgs.follows
        # See https://github.com/NixOS/nix/issues/5790
        vera-clang.follows = "vera-clang";
      };
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nixos-hardware
    , flake-utils
    , pre-commit-hooks
    , hosts
    , ecsls
    , ...
    }:
    let
      username = "sigmanificient";
      system = "x86_64-linux";

      pkgs-settings = {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs = import nixpkgs (pkgs-settings // {
        overlays = [
          (_: _: {
            unstable = import nixpkgs-unstable pkgs-settings;
          })
        ];
      });
    in
    flake-utils.lib.eachSystem [ system ]
      (system: rec {
        formatter = pkgs.nixpkgs-fmt;

        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.nixpkgs-fmt = {
            enable = true;
            name = pkgs.lib.mkForce "Nix files format";
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (checks.pre-commit-check) shellHook;
          packages = [ pkgs.unstable.qtile ];
        };
      })
    // {
      nixosConfigurations.Bacon = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit username pkgs;
          hostname = "Bacon";
        };

        modules = [
          ./system
          ./hardware-configuration.nix
        ] ++ [
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
        ] ++ [
          hosts.nixosModule
          ({
            networking.stevenBlackHosts.enable = true;
          })
        ] ++ (with nixos-hardware.nixosModules; [
          asus-battery
          common-pc-laptop
          common-cpu-amd
          common-pc-ssd
        ]);
      };
    };
}
