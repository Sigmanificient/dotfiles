{
  description = "Sigmachine configuration & dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hosts.url = github:StevenBlack/hosts;
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      nixosConfigurations = (import ./machines {
        inherit home-manager;
        inherit hosts;
        inherit nixpkgs;
        inherit nixpkgs-unstable;
        inherit nixos-hardware;
        inherit self;
        inherit system;
        inherit unstable;
      });
    };
}
