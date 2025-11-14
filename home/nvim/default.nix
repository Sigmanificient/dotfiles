{ pkgs, pkgs-stable, ... }:
let
  hls = pkgs-stable.haskell.packages.ghc984.haskell-language-server;
in
{
  home.file = {
    nvim_conf = {
      source = ./lua;
      target = ".config/nvim/lua";
      recursive = true;
    };

    clang_tidy = {
      source = ./.clang-tidy;
      target = ".clang-tidy";
    };

    clangd = {
      source = ./.clangd;
      target = ".clangd";
    };
  };

  programs.neovim = {
    enable = true;

    extraConfig = (builtins.readFile ./.vimrc);
    plugins = [ pkgs.vimPlugins.lazy-nvim ];

    extraPackages = with pkgs; [
      nil
      lua-language-server
      pyright
      clang-tools
      llvmPackages.clang
      llvmPackages.clang-tools
      nodejs
      xclip
      fzf-make
      typescript-language-server
      hls
    ];
  };
}
