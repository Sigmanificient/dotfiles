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

    profile = {
      source = ./../.profile;
      target = ".profile";
    };

    wallpaper = {
     source = ./../assets/wallpaper.png;
     target = "assets/wallpaper.png";
    };
  };
}
