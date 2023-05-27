{ config, pkgs, ... }:
{
  services = {
    xserver.enable = false;
    openssh.enable = true;

    minecraft-server = {
      enable = true;
      eula = true;

      declarative = true;

      serverProperties = {
        server-port = 3301;
        difficulty = 3;
        gamemode = 0;
        max-players = 5;
        motd = "NixOS Minecraft server!";
        enable-rcon = true;
        "rcon.password" = "op";
      };
    };
  };
}
