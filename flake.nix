{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-qtile-0-36.url = "github:NixOS/nixpkgs/83b8ff5ad36094db6f339a8151cade8f01caaa0d";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    catppuccin = {
      type = "github";
      owner = "catppuccin";
      repo = "nix";
    };

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
    , nixpkgs-qtile-0-36
    , nixpkgs-stable
    , home-manager
    , nixos-hardware
    , pre-commit-hooks
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

      pkgs-stable = import nixpkgs-stable { inherit system; };

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
            inherit catppuccin username system pkgs-stable;

            spicePkgs = spicetify-nix.legacyPackages.${system};
          };
        };
      };

      qtile = (import nixpkgs-qtile-0-36 { inherit system; }).python3Packages.qtile.overrideAttrs (prev: {
        dontUsePytestCheck = true; # tests are slow
      });
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks.nixpkgs-fmt = {
          enable = true;
          name = lib.mkForce "Nix files format";
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        packages = [ qtile ];
      };

      packages.${system} = {
        screenshot-system = import ./screenshot.nix {
          inherit pkgs username;

          # lets use the lightest one
          nixos-system = self.nixosConfigurations.Gha;
        };

        qwerty-fr = pkgs.callPackage ./system/qwerty-fr.nix { };

        inherit qtile;
      };
    }
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
                inherit catppuccin username qtile;
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
                  fsType = "auto";
                };
              }
            ];
          };
        };
      }
    );
}
