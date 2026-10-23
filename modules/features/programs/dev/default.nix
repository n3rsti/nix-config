{ self, ... }:
{
  flake.homeModules.dev =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.neovim
        self.homeModules.lua
        self.homeModules.nix
        self.homeModules.opencode
        self.homeModules.git

        self.homeModules.kubernetes
        self.homeModules.infra
        self.homeModules.java
        self.homeModules.javascript
        self.homeModules.go
        self.homeModules.python
        self.homeModules.c
        self.homeModules.odin
        self.homeModules.zig
        self.homeModules.rust
      ];

      home.packages = with pkgs; [
        unstable.devenv
        fixjson
        bash-language-server # Bash lsp
        beautysh # Bash formatter
        leetcode-cli
        vscodium-fhs
        dbeaver-bin
        bruno # Http / requests testing
      ];
    };
}
