{
  config,
  lib,
  ...
}:
{

  services.immich.enable = true;

  services.tailscale = lib.mkIf config.services.tailscale.enable {
    serve = {
      enable = true;
      services = {
        immich = {
          endpoints = {
            "tcp:443" = "http://localhost:2283";
          };
        };
      };
    };
  };
}
