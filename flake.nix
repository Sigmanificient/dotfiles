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

    catppuccin = {
      type = "github";
      owner = "catppuccin";
      repo = "nix";
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

    ehcsls.url = "github:Sigmapitech/ehcsls";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , flake-utils
    , pre-commit-hooks
    , ecsls
    , ehcsls
    , catppuccin
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
          users.${username}.imports = [
            catppuccin.homeManagerModules.catppuccin
            ./home
          ];

          extraSpecialArgs = {
            inherit catppuccin username system ecsls ehcsls pkgs;
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
          packages = [ pkgs.python312Packages.qtile ];
        };

        packages = {
          screenshot-system = import ./screenshot.nix {
            inherit nixpkgs pkgs home-manager-config;
            inherit (home-manager.nixosModules) home-manager;
          };

          qwerty-fr = pkgs.callPackage ./system/qwerty-fr.nix { };
        };
      })
    // (
      let
        nhw-mod = nixos-hardware.nixosModules;

        mk-base-paths = hostname: let
          key = pkgs.lib.toLower hostname;
        in [
           ./system/_${key}.nix
           ./hardware/${key}.hardware-configuration.nix
        ];


        mk-system = hostname: specific-modules:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit catppuccin username pkgs;
            };

            modules = [ ./system ] ++ (mk-base-paths hostname) ++ [
              { networking.hostName = hostname; }
              { nixpkgs.hostPlatform = system; }
            ] ++ [
              catppuccin.nixosModules.catppuccin
              home-manager.nixosModules.home-manager
              home-manager-config
            ] ++ specific-modules;
          };
      in
      {
        nixosConfigurations = {
          Sigmachine = mk-system "Sigmachine" (with nhw-mod; [
            common-pc-laptop
            common-cpu-intel
            common-pc-ssd
          ]);

          Bacon = mk-system "Bacon" (with nhw-mod; [
            common-cpu-intel
            common-pc-ssd
          ]);

          Toaster = mk-system "Toaster" [ ];
        };
      }
    );
}
