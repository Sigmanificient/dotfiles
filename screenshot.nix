{ pkgs, Sigmachine, username }:
let
  vm-config = { config, lib, ... }:
    {
      boot.consoleLogLevel = lib.mkForce 7;

      environment.systemPackages = with pkgs; let
        auto-cbonsai = (pkgs.writeShellScriptBin "auto_cbonsai" ''
          xdotool getactivewindow windowmove 80 80
          xdotool getactivewindow windowsize 400 400

          clear
          sleep 1

          cbonsai --seed=4
        '');

        auto-neofetch = (pkgs.writeShellScriptBin "auto_neofetch" ''
          clear
          sleep 1

          xdotool getactivewindow windowmove 1080 600
          neofetch
        '');
      in
      [
        cbonsai
        neofetch
      ] ++ [
        kitty
        picom
        xdotool
      ] ++ [
        auto-cbonsai
        auto-neofetch
      ];

      users.users.${username} = {
        isNormalUser = true;
        uid = 1000;
      };

      services = {
        xserver = {
          enable = true;
          displayManager = {
            startx.enable = lib.mkForce false;
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
in
pkgs.testers.runNixOSTest {
  name = "screenshot-system";

  node = {
    inherit pkgs;

    specialArgs = Sigmachine.conf.specialArgs;
    pkgsReadOnly = false;
  };

  nodes = {
    machine.imports =
      Sigmachine.conf.modules
      ++ [ vm-config ];
  };

  testScript = ''
    with subtest("ensure x starts"):
        machine.wait_for_x()
        machine.wait_for_file("/home/sigmanificient/.Xauthority")
        machine.succeed("xauth merge ~sigmanificient/.Xauthority")

    with subtest("ensure we can open a new terminal"):
        machine.sleep(2)

        machine.send_key("meta_l-ret")
        machine.wait_for_window("zsh", timeout=5)

        machine.shell_interact()
        machine.sleep(2)

        for key in "auto_cbonsai":
          machine.send_key(key)
        machine.send_key("ret")
        machine.sleep(15)

        machine.send_key("meta_l-ret")
        machine.sleep(2)

        machine.shell_interact()
        machine.sleep(2)

        for key in "auto_neofetch":
          machine.send_key(key)
        machine.send_key("ret")

        machine.sleep(30)
        machine.screenshot("terminal")
  '';
}
