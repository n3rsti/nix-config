{ self, ... }:
{
  flake.homeModules.application-suite = { pkgs, ... }: {
    imports = [
      self.homeModules.browsers
      self.homeModules.communication
      self.homeModules.documents
      self.homeModules.maker
      self.homeModules.media
      self.homeModules.productivity
      self.homeModules.files
    ];

    home.packages = with pkgs; [
      cheese # Camera
      copyq
      eog
      gnome-online-accounts-gtk
      unstable.bitwarden-desktop
    ];
  };
}
