{
  description = "Sigma dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    ecsls.url = "github:Sigmapitech-meta/ecsls";
    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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

      nixosConfigurations =
        let
          username = "sigmanificient";
        in
        {
          Bacon = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit username;
              hostname = "Bacon";
            };

            modules =
              let
                mod-home-mananger = home-manager.nixosModules.home-manager {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${username} = import ./home;
                    extraSpecialArgs = {
                      inherit username system ecsls;
                    };
                  };
                };

                mod-hosts = hosts.nixosModule {
                  networking.stevenBlackHosts.enable = true;
                };

                mod-nixhardware-lst = with nixos-hardware.nixosModules; [
                  asus-battery
                  common-cpu-amd
                  common-pc
                  common-pc-ssd
                ];
              in
              [
                ./config
                ./hardware-configuration.nix
                ./config/bacon.nix
                mod-home-mananger
                mod-hosts
              ]
              ++ mod-nixhardware-lst;
          };
        };
    };
}
