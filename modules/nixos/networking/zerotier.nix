_:
{
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "56374ac9a42a3c0f" ];
  };

  networking.firewall.allowedUDPPorts = [
    9993
  ];
}
