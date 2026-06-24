{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.audio
      self.nixosModules.bluetooth
      self.nixosModules.flatpak
      self.nixosModules.gnome-services
      self.nixosModules.hyprland
      self.nixosModules.input
      self.nixosModules.printing
      self.nixosModules.gdm
      self.nixosModules.noctalia
    ];
  };

  flake.homeModules.desktop = {
    imports = [
      self.homeModules.session
      self.homeModules.theme
      self.homeModules.desktop-tools
      self.homeModules.hyprland
      self.homeModules.desktop-apps
      self.homeModules.desktop-files
      self.homeModules.launcher
      self.homeModules.noctalia
    ];
  };
}
