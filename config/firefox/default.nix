{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    package = pkgs.wrapFirefox pkgs.firefox-bin-unwrapped
      (import ./extra_policies.nix { inherit pkgs; });

    profiles = {
      sigmanificient = {
        id = 0;
        name = "sigmanificient";
        search = {
          force = true;
          default = "DuckDuckGo";
        };
        settings = {
          "general.smoothScroll" = true;
        };
      };
    };
  };
}
