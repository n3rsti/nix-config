{
  flake.homeModules.desktop-apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        cheese # Camera
        copyq
        eog
        gnome-online-accounts-gtk
        gnome-text-editor
        switcheroo # Converting image formats
        unstable.bitwarden-desktop
      ];
    };
}
