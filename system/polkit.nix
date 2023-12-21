{ pkgs, ... }:
let
  pgaa = "polkit-gnome-authentication-agent-1";
in
{
  security.polkit.enable = true;

  systemd = {
    user.services.${pgaa} = {
      description = pgaa;
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/${pgaa}";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
