{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "qwerty-fr";
  version = "0.7.3";

  src = pkgs.fetchzip {
    url = "https://github.com/qwerty-fr/${pname}/releases/download/v${version}/${pname}_${version}_linux.zip";
    sha256 = "sha256-BZLp5Tw1BH/m1wHYAUbfP86uZ6poAjD2D/uvl2ajmi0=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out
    mv usr $out/usr
  '';
}
