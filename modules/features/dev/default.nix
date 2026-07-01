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
        self.homeModules.dev-tools
        self.homeModules.terminal
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
        microcontrollers.enable = lib.mkDefault true;
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

    dev.microcontrollers.enable = lib.mkDefault true;
  };
}
