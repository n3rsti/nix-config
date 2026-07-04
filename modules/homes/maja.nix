{ self, ... }:
{
  flake.homeModules.maja = {
    imports = [
      self.homeModules.desktop
      self.homeModules.gaming
      self.homeModules.application-suite
    ];

    programs.home-manager.enable = true;

    home.username = "Maja";
    home.homeDirectory = "/home/Maja";
    home.stateVersion = "24.11";
  };
}
