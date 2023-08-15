with import <nixpkgs> {};
mkShell {
  name = "pip-env";
  buildInputs = with python3.pkgs; [
    black
    isort
    qtile
  ];
}
