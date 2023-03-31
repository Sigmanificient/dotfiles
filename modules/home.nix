{ config, pkgs, ... }:
{
  home = {
    username = "sigmanificient";
    homeDirectory = "/home/sigmanificient";

    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Sigmanificient";
      userEmail = "edhyjox" + "@" + "gmail.com";

      extraConfig.url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };

      ignores = [
        # C commons
        "*.gc??"
        "vgcore.*"
        # Python
        "venv"
        # Locked Files
        "*~"
        # Mac folder
        ".DS_Store"
        # Direnv
        ".direnv"
        ".envrc"
        # IDE Folders
        ".idea"
        ".vscode"
        ".vs"
      ];
    };
  };
}
