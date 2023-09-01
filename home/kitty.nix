{ ... }:
{
  programs.kitty = {
    enable = true;

    environment = {
      "LS_COLORS" = "1";
    };

    font = {
      name = "JetbrainsMono Nerd Font";
      size = 9;
    };

    settings = {
      # Window
      hide_window_decorations = "yew";
      dynamic_background_opacity = "yes";

      # Tabs
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "separator";
      tab_separator = " | ";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # colors
      active_tab_foreground = "#0F0F1C";
      active_tab_background = "#8B8AF1";
      inactive_tab_foreground = "#B4C0EC";
      inactive_tab_background = "#1A1C31";
      tab_bar_background = "#0F0F1C";

      foreground = "#CAD3F5";
      background = "#1A1C31";
      selection_foreground = "#000000";
      selection_background = "#A7A5FB";
      url_color = "#8B8AF1";
      cursor = "#82E3F8";

      color0 = "#0F0F1C";
      color1 = "#D22942";
      color2 = "#17B67C";
      color3 = "#F2A174";
      color4 = "#8C8AF1";
      color5 = "#D78AF1";
      color6 = "#8ADEF1";
      color7 = "#CAD3F5";
      color8 = "#A2B1E8";
      color9 = "#DE4259";
      color10 = "#3FD7A0";
      color11 = "#EED49F";
      color12 = "#A7A5FB";
      color13 = "#E5A5FB";
      color14 = "#A5EBFB";
      color15 = "#CAD3F5";

      # Other
      initial_window_width = 820;
      initial_window_height = 460;
      remember_window_size = "no";

      window_padding_width = 5;

      # Aaaaaaaaaaaaaaaah the bell
      enable_audio_bell = false;
    };
  };
}
