{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      url = "github:nix-community/home-manager";
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

      pkgs = import nixpkgs ({
        inherit system;
        config.allowUnfree = true;
      });

      home-manager-config = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username} = import ./home;
          extraSpecialArgs = {
            inherit username system ecsls pkgs;
          };
        };
      };

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
          packages = [ pkgs.qtile ];
        };

        packages = {
          screenshot-system = import ./screenshot.nix {
            inherit nixpkgs pkgs home-manager-config;
            inherit (home-manager.nixosModules) home-manager;
          };

          qwerty-fr = pkgs.callPackage ./system/qwerty-fr.nix { };
        };
      })
    // {
      nixosConfigurations.Bacon = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit username pkgs;
        };

        modules = [
          ./system
          ./hardware-configuration.nix
        ] ++ [
          { networking.hostName = "Bacon"; }
          { nixpkgs.hostPlatform = system; }
        ] ++ [
          home-manager.nixosModules.home-manager
          home-manager-config
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
