{ pkgs, nixos-system, username }:
let
  inherit (pkgs) lib;

  auto-cbonsai = (pkgs.writeShellScriptBin "auto_cbonsai" ''
    ${lib.getExe pkgs.xdotool} getactivewindow windowmove 80 80
    ${lib.getExe pkgs.xdotool} getactivewindow windowsize 400 400

    sleep 1
    clear
    ${lib.getExe pkgs.cbonsai} --seed=4
  '');

  auto-fetch = (pkgs.writeShellScriptBin "auto_fetch" ''
    ${lib.getExe pkgs.xdotool} getactivewindow windowmove 1080 600

    sleep 1
    clear
    ${lib.getExe pkgs.fastfetch}
  '');

  vm-config = { config, lib, ... }:
    {
      boot.consoleLogLevel = lib.mkForce 7;

      environment.systemPackages = with pkgs; [
        cbonsai
        fastfetch
      ] ++ [
        kitty
        picom
        xdotool
      ] ++ [
        auto-cbonsai
        auto-fetch
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

      virtualisation = {
        resolution = {
          x = 1920;
          y = 1200;
        };
        # virtualisation.resolution fallback
        qemu.options = [ "-vga none -device virtio-gpu-pci,xres=1920,yres=1200" ];
      };
    };
in
pkgs.testers.runNixOSTest {
  name = "screenshot-system";

  node = {
    inherit pkgs;

    specialArgs = nixos-system.conf.specialArgs;
    pkgsReadOnly = false;
  };

  nodes = {
    machine.imports =
      nixos-system.conf.modules
      ++ [ vm-config ];
  };

  testScript = ''
    socket_file = "/home/${username}/.cache/qtile/qtilesocket.:0"

    machine.wait_for_x()
    machine.wait_for_file("/home/${username}/.Xauthority")
    machine.succeed("xauth merge ~${username}/.Xauthority")

    machine.wait_until_succeeds(f"${lib.getExe' pkgs.coreutils "test"} -S '{socket_file}'")
    machine.wait_until_succeeds(f"qtile cmd-obj -f windows --socket {socket_file}")

    machine.succeed("mkdir /home/${username}/.ssh") # skip ssh setup

    machine.sleep(1)
    machine.execute(
      "qtile cmd-obj -o cmd -f spawn"
      " -a 'kitty sh -c \"${lib.getExe auto-fetch} && cat -\" '"
      f" --socket {socket_file} & disown")

    machine.sleep(1)
    machine.execute(
      "qtile cmd-obj -o cmd -f spawn"
      " -a 'kitty sh -c \"${lib.getExe auto-cbonsai} && cat -\" '"
      f" --socket {socket_file} & disown")

    machine.sleep(10)
    machine.screenshot("terminal")
  '';
}
