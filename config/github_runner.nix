{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.1"
  ];

  services.github-runner = {
    enable = true;
    tokenFile = "/run/secrets/github-runner/nixos.token";
    url = "https://github.com/Sigmapitech";
  };
}
