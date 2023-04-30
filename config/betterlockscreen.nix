{ pkgs, ... }:
{
  services.betterlockscreen.enable = true;

  home.file.lockscreen = {
    source = ./../assets/lockscreen.png;
    target = "lockscreen.png";
  };
}
