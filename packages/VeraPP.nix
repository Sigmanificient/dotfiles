{stdenv, fetchFromGitHub, cmake, python3, boost, tcl}:

stdenv.mkDerivation {
  pname = "vera++";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Epitech";
    repo = "banana-vera";
    rev = "3a7d18d6249cd1790cc63fb9018e0914462ec219";
    sha256 = "sha256-1nAKhUltQS1301JNrr0PQQrrf2W9Hj5gk1nbUhN4cXw=";
  };

  nativeBuildInputs = [cmake];
  buildInputs = [
    python3
    (boost.override { enablePython = true; python = python3; })
    tcl
  ];

  cmakeFlags = [
    "-DVERA_LUA=OFF"
    "-DVERA_USE_SYSTEM_BOOST=ON"
    "-DPANDOC=OFF"
  ];
}
