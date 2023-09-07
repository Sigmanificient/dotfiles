{ ... }:
{
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
