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

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixos-hardware
    , flake-utils
    , pre-commit-hooks
    , ecsls
    , ehcsls
    , catppuccin
    , spicetify-nix
    , ...
    }:
    let
      inherit (nixpkgs) lib;

      username = "sigmanificient";
      system = "x86_64-linux";

      pkgs = import nixpkgs ({
        inherit system;
        config.allowUnfree = true;
      });

      home-manager-config = home-base: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${username}.imports = [
            catppuccin.homeModules.catppuccin
            spicetify-nix.homeManagerModules.spicetify
            home-base
          ];

          extraSpecialArgs = {
            inherit catppuccin username system ecsls ehcsls;

            spicePkgs = spicetify-nix.legacyPackages.${system};
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
            name = lib.mkForce "Nix files format";
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (checks.pre-commit-check) shellHook;
          packages = [ pkgs.python312Packages.qtile ];
        };

        packages = {
          screenshot-system = import ./screenshot.nix {
            inherit pkgs username;

            # lets use the lightest one
            nixos-system = self.nixosConfigurations.Gha;
          };

          qwerty-fr = pkgs.callPackage ./system/qwerty-fr.nix { };
        };
      })
    // (
      let
        nhw-mod = nixos-hardware.nixosModules;

        mk-base-paths = hostname:
          let
            key = lib.toLower hostname;
          in
          [
            ./system/_${key}.nix
            ./hardware/${key}.hardware-configuration.nix
          ];

        mk-system =
          { hostname
          , hasHostSpecific ? true
          , specific-modules ? [ ]
          , base ? ./system
          , home-base ? ./home
          }:
          let
            conf = {
              specialArgs = {
                inherit catppuccin username;
              };

              modules = [ base ]
              ++ (lib.optionals hasHostSpecific (mk-base-paths hostname))
              ++ [
                { networking.hostName = hostname; }
                { nixpkgs.hostPlatform = system; }
                { nixpkgs.pkgs = pkgs; }
              ] ++ [
                catppuccin.nixosModules.catppuccin
                home-manager.nixosModules.home-manager
                (home-manager-config home-base)
              ] ++ specific-modules;
            };
          in
          (lib.nixosSystem conf) // { inherit conf; };
      in
      {
        nixosConfigurations = {
          Sigmachine = mk-system {
            hostname = "Sigmachine";

            specific-modules = (with nhw-mod; [
              lenovo-thinkpad-p16s-intel-gen2
            ]);
          };

          Bacon = mk-system {
            hostname = "Bacon";

            specific-modules = (with nhw-mod; [
              common-cpu-intel
              common-pc-ssd
            ]);
          };

          Toaster = mk-system {
            hostname = "Toaster";
          };

          Gha = mk-system {
            hostname = "Gha";
            hasHostSpecific = false;

            base = ./system/minimal.nix;
            home-base = ./home/minimal.nix;

            specific-modules = [
              {
                system.stateVersion = "25.05";
                fileSystems."/" = {
                  device = "nodev";
                };
              }
            ];
          };
        };
      }
    );
}
