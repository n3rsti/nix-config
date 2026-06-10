{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop;
in
{
  imports = [
    ./browsers.nix
    ./communication.nix
    ./documents.nix
    ./maker.nix
    ./media.nix
    ./network.nix
    ./productivity.nix
  ];

  options.profile.programs.desktop.enable = lib.mkEnableOption "desktop applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      baobab # Disk usage analyzer
      cheese # Camera
      copyq
      eog
      gnome-disk-utility # Disks
      gnome-online-accounts-gtk
      gnome-text-editor
      nautilus
      networkmanagerapplet # For nm-connection-editor
      nmgui # Wifi gui
      resources
      switcheroo # Converting image formats
      unstable.bitwarden-desktop
    ];
  };
}
