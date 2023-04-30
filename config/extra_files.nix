{ pkgs, ... }:
{
  home.file = {
    bashrc = {
      source = ./../.bashrc;
      target = ".bashrc";
    };

    xinitrc = {
      source = ./../.xinitrc;
      target = ".xinitrc";
    };

    wallpaper = {
      source = ./../assets/wallpaper.png;
      target = "assets/wallpaper.png";
    };
  };
}
