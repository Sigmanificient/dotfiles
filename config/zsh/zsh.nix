{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    initExtra = "source $HOME/.profile";

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "2d60a47cc407117815a1d7b331ef226aa400a344";
          sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
        };
      }
      {
        name = "zsh-wakatime";
        src = pkgs.fetchFromGitHub {
          owner = "wbingli";
          repo = "zsh-wakatime";
          rev = "7396e143f2eb048a4a6d64dacae81c52e1ad72ab";
          sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "eee8bbeb717e44dc6337a799ae60eda02d371b73";
          sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
        };
      }
    ];

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake . --upgrade";
      dodo = "shutdown now";
    };

    oh-my-zsh = {
      enable = true;

      custom = "$HOME/extra/zsh";
      theme = "sigma";

      plugins = [
        "git"
        "ssh-agent"
      ];
    };
  };

  home.file.omz_zsh_theme = {
    source = ./sigma.zsh-theme;
    target = "extra/zsh/themes/sigma.zsh-theme";
  };
}
