{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    ecsls.url = "github:Sigmapitech/ecsls";
    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , pre-commit-hooks
    , ...
    } @ inputs:
    let
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
    {
      nixosConfigurations = {
        Bacon = nixpkgs.lib.nixosSystem
          (import ./bacon.nix { inherit inputs system pkgs; });
      };
    } // flake-utils.lib.eachSystem [ system ] (system: rec {
      formatter = pkgs.nixpkgs-fmt;

      checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt = {
            enable = true;
            name = pkgs.lib.mkForce "Nix files format";
          };
        };
      };

      devShells.default = pkgs.mkShell {
        inherit (checks.pre-commit-check) shellHook;
      };
    });
}
