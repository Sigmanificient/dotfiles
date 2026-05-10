{ ... }:
{
  programs.fastfetch.enable = true;

  home.file = {
    fastfetch_conf = {
      source = ./config.jsonc;
      target = ".config/fastfetch/config.jsonc";
    };
  };
}
