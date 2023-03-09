{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  description = "Sigmachine configuration & dotfiles";

  outputs = { self, nixpkgs, nixpkgs-unstable }@inputs:
  let
      system = "x86_64-linux";
      unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.Sigmachine = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./.config/nixos/hardware-configuration.nix
        (import ./.config/nixos/configuration.nix { inherit unstable; })
      ];
    };
  };
}
