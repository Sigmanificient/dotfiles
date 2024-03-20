{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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

  outputs = { nixpkgs, nixpkgs-unstable, pre-commit-hooks, ... } @ inputs:
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
    rec {
      formatter.${system} = pkgs.nixpkgs-fmt;

      checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt = {
            enable = true;
            name = pkgs.lib.mkForce "Nix files format";
          };
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        inherit (checks.${system}.pre-commit-check) shellHook;
      };

      nixosConfigurations = {
        Bacon = nixpkgs.lib.nixosSystem
          (import ./bacon.nix { inherit inputs system pkgs; });
      };
    };
}
