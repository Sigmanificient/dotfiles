{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    extraConfig = ''
      lua require('sigma')
    '';

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      nil # nix
      lua-language-server
    ];
  };
}
