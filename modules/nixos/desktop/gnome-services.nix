{ pkgs, ... }:
{
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    udisks2.enable = true;
    gvfs.enable = true; # for nautilus

    gnome = {
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };

    udev.packages = [
      pkgs.openocd
      pkgs.stlink
    ];
  };
}
