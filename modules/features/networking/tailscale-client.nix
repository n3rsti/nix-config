{ self, ... }:
{
  flake.homeModules.tailscale-client = {
    services.tailscale-systray.enable = true;
  };

  flake.nixosModules.tailscale-client =
    {
      ...
    }:
    {
      imports = [
        self.nixosModules.tailscale
      ];
      services = {
        tailscale = {
          extraSetFlags = [
            "--accept-dns"
            "--accept-routes"
            "--exit-node-allow-lan-access"
          ];
        };
        resolved.enable = true; # fix tailscale dns after suspend
      };
    };
}
