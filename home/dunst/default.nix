{ pkgs, ... }:
{
  services.dunst = {
    enable = true;

    settings = (import ./settings.nix { inherit pkgs; });
  };
}
