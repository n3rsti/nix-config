{
  flake.nixosModules.gnome-services = _: {
    services = {
      udisks2.enable = true;
      gvfs.enable = true; # for nautilus

      gnome = {
        evolution-data-server.enable = true;
        gnome-keyring.enable = true;
        gnome-online-accounts.enable = true;
      };
    };
  };
}
