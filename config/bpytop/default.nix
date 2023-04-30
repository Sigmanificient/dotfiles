{ pkgs, ... }:
{
  home.file = {
    bpytop_config = {
      source = ./bpytop.conf;
      target = ".config/bpytop/bpytop.conf";
    };

    bpytop_theme = {
      source = ./sigma.theme;
      target = ".config/bpytop/themes/sigma.theme";
    };
  };
}
