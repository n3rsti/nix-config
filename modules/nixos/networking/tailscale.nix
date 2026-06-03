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
    resolved.enable = true;
  };

  networking.firewall.checkReversePath = "loose";

  # fix tailscale dns after suspend
}
