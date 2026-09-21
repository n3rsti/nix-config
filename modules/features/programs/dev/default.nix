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
      ];

      home.packages = with pkgs; [
        unstable.devenv
        fixjson
        bash-language-server # Bash lsp
        beautysh # Bash formatter
        leetcode-cli
      ];
    };
}
