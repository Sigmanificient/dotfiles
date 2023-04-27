{ config, pkgs, ... }:
{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        uiColor = "#1435c7";
      };
    };
  };
}
