{ pkgs, ... }:
{
  home.file = {
    xinitrc = {
      source = ./../.xinitrc;
      target = ".xinitrc";
    };

    wallpaper = {
      source = ./../assets/wallpaper.png;
      target = "assets/wallpaper.png";
    };

    wakatime-cli = {
      source = pkgs.lib.getExe pkgs.wakatime-cli;
      target = ".wakatime/wakatime-cli";
    };
  };
}
