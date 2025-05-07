{ pkgs, ecsls, ehcsls, system, ... }:
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

    extraPackages = with pkgs; let
      getLsp = flake: flake.packages.${system}.default;
      ecsls-pkg = getLsp ecsls;
      ehcsls-pkg = getLsp ehcsls;
    in
    [
      nil
      lua-language-server
      pyright
      clang-tools
      llvmPackages.clang
      llvmPackages.clang-tools
      nodejs
      xclip
      ecsls-pkg
      ehcsls-pkg
      haskell.packages.ghc984.haskell-language-server
      fzf-make
    ];
  };
}
