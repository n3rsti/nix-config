{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.audio
      self.nixosModules.bluetooth
      self.nixosModules.flatpak
      self.nixosModules.gnome-services
      self.nixosModules.input
      self.nixosModules.printing
      self.nixosModules.gdm
    ];
  };

  flake.homeModules.desktop = {
    imports = [
      self.homeModules.session
      self.homeModules.theme
      self.homeModules.desktop-tools
      self.homeModules.desktop-apps
      self.homeModules.desktop-files
    ];
  };
}
