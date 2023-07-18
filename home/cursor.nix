{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 24;
  };
}
