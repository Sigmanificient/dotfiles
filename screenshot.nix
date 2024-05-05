{ nixpkgs
, home-manager-config
, home-manager
, pkgs
}:
let
  vm-config = { config, lib, ... }:
    let
      username = "sigmanificient";
      sysconf = (import ./system { inherit config pkgs username; });
    in
    {
      inherit (sysconf) fonts programs time nixpkgs;

      imports = [
        home-manager
        home-manager-config
      ];

      boot.consoleLogLevel = lib.mkForce 7;
      environment.systemPackages = with pkgs; [
        kitty
        libnotify
        picom
        xorg.xrandr
      ];

      users.users.${username} = {
        isNormalUser = true;
        password = "foobar";
        uid = 1000;
      };

      services = {
        xserver = {
          inherit (sysconf.services.xserver) windowManager;

          enable = true;
          displayManager = {
            startx.enable = false;
            autoLogin = {
              enable = true;
              user = username;
            };
          };
        };
      };

      virtualisation.resolution = {
        x = 1920;
        y = 1080;
      };
    };

  testScript = ''
    def send_command(text: str) -> None:
        for char in text:
            machine.send_key(char)
        machine.send_key("ret")
        machine.sleep(1)

    with subtest("ensure x starts"):
        machine.wait_for_x()
        machine.wait_for_file("/home/sigmanificient/.Xauthority")
        machine.succeed("xauth merge ~sigmanificient/.Xauthority")

    with subtest("ensure client is available"):
        machine.succeed("qtile --version")

    with subtest("ensure we can open a new terminal"):
        machine.sleep(2)
        machine.send_key("meta_l-ret")
        machine.sleep(4)

        machine.shell_interact()

        send_command("picom -f &")
        send_command("clear")
        send_command("neofetch")

        machine.sleep(2)
        machine.screenshot("terminal")
  '';
in
pkgs.stdenvNoCC.mkDerivation {
  name = "screenshot-system";
  version = "1.0.0";

  src = ./.;
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    cp -r $src $out
  '';

  passthru.tests.qtile =
    let
      nixos-lib = import (nixpkgs + "/nixos/lib") { };
    in
    nixos-lib.runTest {
      inherit testScript;

      name = "test";
      nodes.machine = vm-config;
      hostPkgs = pkgs;
    };
}
