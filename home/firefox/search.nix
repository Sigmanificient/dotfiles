{ pkgs, ... }:
{
  force = true;
  default = "DuckDuckGo";
  engines = {
    "Nix Packages" = {
      urls = [{
        template = "https://search.nixos.org/packages";
        params = [
          { name = "type"; value = "packages"; }
          { name = "query"; value = "{searchTerms}"; }
        ];
      }];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };

    "Bing".metaData.hidden = true;
    "Google".metaData.alias = "@g";
  };
}
