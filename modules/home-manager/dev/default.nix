{ lib, ... }:
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
    java.enable = true;
    c.enable = true;
    python.enable = true;
    rust.enable = true;
    go.enable = true;
    nix.enable = true;
    lua.enable = true;
    typst.enable = true;
    javascript.enable = true;
    kotlin.enable = lib.mkDefault true; # TODO: find a better solution
  };
}
