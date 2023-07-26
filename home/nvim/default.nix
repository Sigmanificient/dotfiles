{ pkgs, ... }:
let vera = pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "banana-vera";
  version = "1.3.0-python3.10";

  src = pkgs.fetchFromGitHub {
    owner = "Epitech";
    repo = "banana-vera";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-1nAKhUltQS1301JNrr0PQQrrf2W9Hj5gk1nbUhN4cXw=";
  };

  nativeBuildInputs = [ pkgs.cmake ];
  buildInputs = with pkgs; [
    python310
    python310.pkgs.boost
    tcl
  ];

  cmakeFlags = [
    "-DVERA_LUA=OFF"
    "-DVERA_USE_SYSTEM_BOOST=ON"
    "-DPANDOC=OFF"
  ];
});
in {
  home.file.nvim_conf = {
    source = ./lua;
    target = ".config/nvim/lua";
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    extraConfig = ''
      lua require('sigma')
    '';

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      vera

      # ↓ Nix
      nil

      # ↓ Lua
      lua-language-server

      # ↓ Python
      nodePackages.pyright

      # ↓ C
      clang-tools
      llvmPackages_latest.clang

      # ↓ Copilot
      nodejs
    ];
  };
}

