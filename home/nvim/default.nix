{ pkgs, ecsls, conf, ... }:
let
  base_pkgs = with pkgs; [
    nil # Nix
    lua-language-server
    nodePackages.pyright
    clang-tools
    llvmPackages_latest.clang
    nodejs # Copilot
    xclip # Clipboard fix
  ];

  extra_pkgs =
    if conf.ecsls.enable
    then base_pkgs ++ [ ecsls.packages.${conf.system}.default ]
    else base_pkgs;
in
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

    extraPackages = extra_pkgs;
  };
}

