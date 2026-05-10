{ pkgs-stable, ... }:
{
  services.flameshot = {
    enable = true;
    package = pkgs-stable.flameshot;
    settings = {
      General = {
        uiColor = "#1435c7";
      };
    };
  };
}
