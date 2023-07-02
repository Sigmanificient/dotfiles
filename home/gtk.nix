{ pkgs, ... }:
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-Macchiato-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
}
