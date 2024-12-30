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
      llvmPackages_latest.clang
      nodejs
      xclip
      ecsls-pkg
      ehcsls-pkg
      (pkgs.callPackage ./fzf-make.nix { })
    ];
  };
}
