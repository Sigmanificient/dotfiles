{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Sigmanificient";
        email = "edhyjox" + "@" + "gmail.com";
      };

      url = {
        init = {
          defaultBranch = "main";
        };

        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
    };

    ignores = [
      # C commons
      ".cache"
      "compile_commands.json"
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
      # Nix buid
      "result"
      # IDE Folders
      ".idea"
      ".vscode"
      ".vs"
    ];
  };
}
