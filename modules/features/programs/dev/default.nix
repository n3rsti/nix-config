{ self, ... }:
{
  flake.homeModules.dev =
    { lib, pkgs, ... }:
    {
      imports = [
        self.homeModules.neovim
        self.homeModules.java
        self.homeModules.c
        self.homeModules.csharp
        self.homeModules.go
        self.homeModules.javascript
        self.homeModules.lua
        self.homeModules.nix
        self.homeModules.typst
        self.homeModules.python
        self.homeModules.rust
        self.homeModules.kotlin
        self.homeModules.microcontrollers
        self.homeModules.opencode
        self.homeModules.git
        self.homeModules.zig
      ];

      dev = {
        nix.enable = lib.mkDefault true;
        lua.enable = lib.mkDefault true;

        java.enable = lib.mkDefault false;
        c.enable = lib.mkDefault false;
        python.enable = lib.mkDefault false;
        rust.enable = lib.mkDefault false;
        go.enable = lib.mkDefault false;
        typst.enable = lib.mkDefault false;
        javascript.enable = lib.mkDefault false;
        kotlin.enable = lib.mkDefault false;
        zig.enable = lib.mkDefault false;
        microcontrollers.enable = lib.mkDefault false;
      };

      home.packages = with pkgs; [
        unstable.devenv
        fixjson
        bash-language-server # Bash lsp
        beautysh # Bash formatter
      ];
    };

  flake.nixosModules.dev = { lib, ... }: {
    imports = [
      self.nixosModules.microcontrollers
    ];

    dev.microcontrollers.enable = lib.mkDefault false;
  };
}
