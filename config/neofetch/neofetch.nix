{ pkgs, ... }:
{
  home.file.neofetch_config = {
    source = ./config.conf;
    target = ".config/neofetch/config.conf";
  };
}
