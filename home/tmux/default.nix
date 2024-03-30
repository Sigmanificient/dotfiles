{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_date_time ""
          set -g @catppuccin_user "off"
          set -g @catppuccin_host "on"
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
