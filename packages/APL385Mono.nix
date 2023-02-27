{ stdenvNoCC, fetchzip, ...}:

stdenvNoCC.mkDerivation {
  pname = "APL385Mono";
  version = "1.0";

  src = fetchzip {
    url = "http://apl385.com/fonts/apl385.zip";
    sha256 = "c53e4a2bb158ef311c7d6573fe7a87211616692f5f536fb9042725b7e62021dc";
  };

  installPhase =
  ''
  runHook preInstall

  mkdir -p $out/share/fonts/truetype/APL385Mono
  cp Apl385.ttf $out/share/fonts/truetype/APL385Mono

  runHook postInstall
  '';
}
