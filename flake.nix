{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    ecsls.url = "github:Sigmapitech/ecsls";
    ehcsls.url = "github:Sigmapitech/ehcsls";

    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with inputs; let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        Bacon = nixpkgs.lib.nixosSystem
          (import ./bacon.nix { inherit inputs system; });
      };
    };
}
