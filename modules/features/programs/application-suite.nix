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
      self.homeModules.ghostty
    ];

    home.packages = with pkgs; [
      cheese # Camera
      copyq
      eog
      gnome-online-accounts-gtk
      unstable.bitwarden-desktop
    ];

    xdg.desktopEntries.bitwarden = {
      name = "Bitwarden";
      comment = "Secure and free password manager for all of your devices";
      exec = "env XDG_CURRENT_DESKTOP=KDE ${pkgs.unstable.bitwarden-desktop}/bin/bitwarden %U";
      icon = "bitwarden";
      type = "Application";
      categories = [ "Utility" ];
      mimeType = [ "x-scheme-handler/bitwarden" ];
    };
  };
}
