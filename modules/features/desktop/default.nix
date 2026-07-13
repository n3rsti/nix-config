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

  flake.homeModules.desktop = { pkgs, ... }: {
    imports = [
      self.homeModules.polkit
      self.homeModules.theme
    ];

    home.packages = with pkgs; [
      glib # Needed for gapplication launching like with gnome-weather
    ];
  };
}
