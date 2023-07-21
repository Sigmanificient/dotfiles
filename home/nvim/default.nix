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
  };
}
