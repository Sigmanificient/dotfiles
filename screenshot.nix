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
      environment.systemPackages = with pkgs; let
        auto-cbonsai = (pkgs.writeShellScriptBin "auto_cbonsai" ''
          xdotool getactivewindow windowmove 80 80
          xdotool getactivewindow windowsize 400 400

          sleep 1
          cbonsai --seed=4 -p
        '');

        auto-neofetch = (pkgs.writeShellScriptBin "auto_neofetch" ''
          picom -f & disown
          xdotool getactivewindow windowmove 1080 600

          neofetch
        '');
      in
      [
        cbonsai
        neofetch
      ] ++ [
        kitty
        libnotify
        picom
        xdotool
        xorg.xrandr
      ] ++ [
        auto-cbonsai
        auto-neofetch
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
    with subtest("ensure x starts"):
        machine.wait_for_x()
        machine.wait_for_file("/home/sigmanificient/.Xauthority")
        machine.succeed("xauth merge ~sigmanificient/.Xauthority")

    with subtest("ensure client is available"):
        machine.succeed("qtile --version")

    with subtest("ensure we can open a new terminal"):
        machine.sleep(4)

        machine.send_key("meta_l-ret")
        machine.wait_for_window("~", timeout=5)

        machine.shell_interact()
        machine.sleep(1)

        for key in "auto_cbonsai":
          machine.send_key(key)
        machine.send_key("ret")

        machine.sleep(4)
        machine.send_key("meta_l-ret")
        machine.sleep(4)

        machine.shell_interact()
        machine.sleep(1)

        for key in "auto_neofetch":
          machine.send_key(key)
        machine.send_key("ret")

        machine.sleep(6)
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
