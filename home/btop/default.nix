{ pkgs, ... }:
{
  home.packages = with pkgs; [ btop ];

  home.file.btop_config = {
    source = ./btop.conf;
    target = ".config/btop/btop.conf";
  };
}
