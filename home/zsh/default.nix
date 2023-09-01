{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "754cefe0181a7acd42fdcb357a67d0217291ac47";
          sha256 = "kWgPe7QJljERzcv4bYbHteNJIxCehaTu4xU9r64gUM4=";
        };
      }
      {
        name = "wakatime";
        src = pkgs.fetchFromGitHub {
          owner = "sobolevn";
          repo = "wakatime-zsh-plugin";
          rev = "69c6028b0c8f72e2afcfa5135b1af29afb49764a";
          sha256 = "pA1VOkzbHQjmcI2skzB/OP5pXn8CFUz5Ok/GLC6KKXQ=";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "eee8bbeb717e44dc6337a799ae60eda02d371b73";
          sha256 = "2qkB8I3GXeg+mH8l12N6dnKtdnaxTeLf5lUHWxA2rNg=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      ll = "ls -l";
      dodo = "shutdown now";
      lz = "lazygit";
      ufda = "echo 'use flake' | tee .envrc && direnv allow";
    };

    oh-my-zsh = {
      enable = true;

      custom = "$HOME/extra/zsh";
      theme = "drawbu";

      plugins = [
        "git"
        "ssh-agent"
      ];
    };
  };

  home.file.omz_zsh_theme = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/drawbu/dotfiles/main/assets/.p10k.zsh";
      sha256 = "sha256-s3omNttaZmiiC6BUfdM9ZxbuUGgsN0s0Ue0vULT1MxY=";
    };
    target = "extra/zsh/themes/drawbu.zsh-theme";
  };
}
