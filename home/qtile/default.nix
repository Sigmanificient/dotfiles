{ ... }:
{
  home.file.qtile_configs = {
    source = ./src;
    target = ".config/qtile";
    recursive = true;
  };
}
