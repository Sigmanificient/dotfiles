{ qtile, ... }:
{
  home.file.qtile_configs = {
    source = "${qtile}/src";
    target = ".config/qtile";
    recursive = true;
  };
}
