{ lib, pkgs, ... }:
{
  imports = [
    ./editor.nix
    ./lang/java.nix
    ./lang/c.nix
    ./lang/csharp.nix
    ./lang/go.nix
    ./lang/javascript.nix
    ./lang/lua.nix
    ./lang/nix.nix
    ./lang/typst.nix
    ./lang/python.nix
    ./lang/rust.nix
    ./lang/kotlin.nix
    ./opencode.nix
    ./git.nix
    ./tools.nix
    ./terminal
  ];

  dev = {
    java.enable = lib.mkDefault true;
    c.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
    go.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    lua.enable = lib.mkDefault true;
    typst.enable = lib.mkDefault true;
    javascript.enable = lib.mkDefault true;
    kotlin.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    unstable.devenv
    fixjson
    arduino-ide
    bash-language-server # Bash lsp
    beautysh # Bash formatter
    stlink # Something for flashing programs to microcontrollers
  ];
}
