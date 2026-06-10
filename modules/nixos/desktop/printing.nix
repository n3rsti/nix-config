{
  pkgs,
  ...
}:
{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    ipp-usb.enable = true; # printers autodiscovery
  };

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
