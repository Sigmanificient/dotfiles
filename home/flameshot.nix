{ colors, ... }:
{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        uiColor = colors.dark.blue;
      };
    };
  };
}
