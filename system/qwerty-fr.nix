{ stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "qwerty-fr";
  version = "0.7.3";

  src = fetchFromGitHub {
    owner = "qwerty-fr";
    repo = "qwerty-fr";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-TD67wKdaPaXzJzjKFCfRZl3WflUfdnUSQl/fnjr9TF8=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/X11/xkb/symbols
    cp $src/linux/us_qwerty-fr $out/share/X11/xkb/symbols

    runHook postInstall
  '';
})
