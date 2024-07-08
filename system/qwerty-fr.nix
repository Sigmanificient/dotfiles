{ stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "qwerty-fr";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "qwerty-fr";
    repo = "qwerty-fr";
    rev = "refs/tags/v${finalAttrs.version}";
    sha256 = "sha256-BZLp5Tw1BH/m1wHYAUbfP86uZ6poAjD2D/uvl2ajmi0=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r usr/share $out/share

    runHook postInstall
  '';
})
