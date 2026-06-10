{
  lib,
  ...
}:
{
  networking.hostName = lib.mkDefault "nixos";

  networking.networkmanager.enable = lib.mkDefault true;

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
