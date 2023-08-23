{ ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "-u ~/assets/lockscreen.png" ];
  };

  home.file.betterlockscreenrc = {
    source = ./betterlockscreenrc;
    target = ".config/betterlockscreenrc";
  };

  home.file.lockscreen = {
    source = ./../../assets/lockscreen.png;
    target = "assets/lockscreen.png";
  };
}
