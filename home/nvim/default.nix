{ pkgs, ecsls, conf, ... }:
{
  home.file.nvim_conf = {
    source = ./lua;
    target = ".config/nvim/lua";
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    extraConfig = ''
      lua require('sigma')
    '';

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      nil # Nix
      lua-language-server
      nodePackages.pyright
      clang-tools
      llvmPackages_latest.clang
      nodejs # Copilot
      xclip # Clipboard fix
      ecsls.packages.${conf.system}.default
    ];

  };
}

