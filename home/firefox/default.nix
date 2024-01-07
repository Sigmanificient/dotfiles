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
        search = (import ./search.nix { inherit pkgs; });
        settings = {
          "browser.newtabpage.pinned" = [
            { title = "NixOS"; url = "https://nixos.org"; }
            { title = "Github"; url = "https://github.com"; }
            { title = "YouTube"; url = "https://youtube.com"; }
          ];
          "general.smoothScroll" = true;
        };
      };
    };
  };
}
