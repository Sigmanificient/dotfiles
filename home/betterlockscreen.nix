{ config, pkgs, ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "-u ~/assets/lockscreen.png" ];
  };

  home.file.lockscreen = {
    source = ./../assets/lockscreen.png;
    target = "assets/lockscreen.png";
  };
}
