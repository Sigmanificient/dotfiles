{ pkgs, ... }:
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
      # ↓ Nix
      nil

      # ↓ Lua
      lua-language-server

      # ↓ Python
      nodePackages.pyright

      # ↓ C
      clang-tools
      llvmPackages_latest.clang
    ];
  };
}
