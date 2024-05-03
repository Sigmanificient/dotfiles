{ inputs, system, pkgs }: with inputs;
let
  username = "sigmanificient";
in
{
  inherit system;

  specialArgs = {
    inherit username pkgs;
    hostname = "Bacon";
  };

  modules =
    let
      home-manager-conf = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = import ./home;
        extraSpecialArgs = {
          inherit username system ecsls;
        };
      };
    in
    [
      ./system
      ./hardware-configuration.nix
    ] ++ [
      home-manager.nixosModules.home-manager
      { home-manager = home-manager-conf; }
      hosts.nixosModule
      ({
        networking.stevenBlackHosts.enable = true;
      })
    ] ++ (with nixos-hardware.nixosModules; [
      asus-battery
      common-pc-laptop
      common-cpu-amd
      common-pc-ssd
    ]);
}
