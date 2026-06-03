{
  config,
  lib,
  ...
}:
{

  services.uptime-kuma = {
    enable = true;
  };

  services.tailscale = lib.mkIf config.services.tailscale.enable {
    serve = {
      enable = true;
      services = {
        uptime-kuma = {
          endpoints = {
            "tcp:443" = "http://localhost:3001";
          };
        };
      };
    };
  };
}
