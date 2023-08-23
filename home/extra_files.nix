{ ... }:
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
  };
}
