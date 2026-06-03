{
  ...
}:
{
  services = {
    tailscale = {
      enable = true;
      extraSetFlags = [
        "--accept-dns"
        "--accept-routes"
        "--exit-node-allow-lan-access"
      ];
    };
    resolved.enable = true; # fix tailscale dns after suspend
  };

  networking.firewall.checkReversePath = "loose";
}
