{ lib, pkgs, ... }:
{
  imports = [
    ./java.nix
    ./c.nix
    ./csharp.nix
    ./go.nix
    ./javascript.nix
    ./lua.nix
    ./nix.nix
    ./typst.nix
    ./python.nix
    ./rust.nix
    ./kotlin.nix
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
    unstable.tree-sitter
    bash-language-server # Bash lsp
    beautysh # Bash formatter
  ];
}
