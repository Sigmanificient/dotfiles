{ ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    initExtra = "source $HOME/.profile";

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake . --upgrade";
      dodo = "shutdown now";
    };

    oh-my-zsh = {
      enable = true;

      custom = "$HOME/extra/zsh";
      plugins = [
        "git"
        "ssh-agent"
        "wakatime"
        "zsh-wakatime"
        "zsh-autocomplete"
        "zsh-syntax-highlighting"
        "zsh-wakatime"
      ];

      theme = "sigma";
    };
  };

   home.file.zsh_theme = {
     source = ./sigma.zsh-theme;
     target = "exta/zsh/themes/sigma.zsh-theme";
   };
}
