{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pkgs.btop
  ];

  home.file.btop_config = {
    source = ./btop.conf;
    target = ".config/btop/btop.conf";
  };
}
