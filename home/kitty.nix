{ colors, ... }:
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
      active_tab_foreground = colors.dark.black;
      active_tab_background = colors.light.blue;
      inactive_tab_foreground = colors.light.white;
      inactive_tab_background = colors.light.black;
      tab_bar_background = colors.dark.black;

      foreground = colors.light.white;
      background = colors.light.black;
      selection_foreground = colors.dark.black;
      selection_background = colors.light.blue;
      url_color = colors.light.white;
      cursor = colors.dark.blue;

      color0 = colors.dark.black;
      color1 = colors.dark.red;
      color2 = colors.dark.green;
      color3 = colors.dark.yellow;
      color4 = colors.dark.blue;
      color5 = colors.dark.magenta;
      color6 = colors.dark.cyan;
      color7 = colors.dark.white;
      color8 = colors.light.black;
      color9 = colors.light.red;
      color10 = colors.light.green;
      color11 = colors.light.yellow;
      color12 = colors.light.blue;
      color13 = colors.light.magenta;
      color14 = colors.light.cyan;
      color15 = colors.light.white;

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
