{
  description = "Sigmachine configuration & dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hosts.url = github:StevenBlack/hosts;
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , home-manager
    , hosts
    , ...
    } @inputs:
    let
      system = "x86_64-linux";
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        Sigmachine = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            # Harware
            nixos-hardware.nixosModules.asus-battery
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd

            # System
            (import ./config)
            hosts.nixosModule
            {
              networking.stevenBlackHosts.enable = true;
            }

            # Home
            home-manager.nixosModules.home-manager
            {
              home-manager.users.sigmanificient =
                (import ./home { inherit unstable; });
            }
          ];
        };
      };
    };
}
