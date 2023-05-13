{ pkgs, ... }:
{
  global = {
    alignment = "left";
    always_run_script = true;
    browser = "${pkgs.firefox-devedition-bin}";

    font = "JetBrainsMono Nerd Font Mono 10";
    frame_color = "#8AADF4";
    separator_color = "frame";

    icon_path = "-";
    indicate_hidden = "yes";

    mouse_left_click = "do_action, close_current";
    mouse_middle_click = "do_action, close_current";
    mouse_right_click = "close_all";

    corner_radius = 4;
    frame_width = 2;
    horizontal_padding = 14;
    padding = 8;
    separator_height = 2;

    show_indicators = "yes";
    sticky_history = "no";
    vertical_alignment = "center";
    word_wrap = "yes";
  };

  urgency_low = {
    background = "#0D0D1680";
    foreground = "#8AADF4";
    timeout = 10;
  };

  urgency_normal = {
    background = "#0D0D1680";
    foreground = "#EED49F";
    timeout = 15;
  };

  urgency_critical = {
    background = "#0D0D1680";
    foreground = "#ED8796";
    timeout = 30;
  };
}
