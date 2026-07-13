{ self, ... }:
{
  flake.homeModules.terminal = {
    imports = [
      self.homeModules.ghostty
      self.homeModules.zsh
    ];
  };
}
