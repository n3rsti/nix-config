{
  config,
  lib,
  ...
}:
{

  services.paperless = {
    enable = true;
    settings = {
      PAPERLESS_URL = "https://paperless.tail3ce7af.ts.net";
    };
  };

  services.tailscale = lib.mkIf config.services.tailscale.enable {
    serve = {
      enable = true;
      services = {
        paperless = {
          endpoints = {
            "tcp:443" = "http://localhost:28981";
          };
        };
      };
    };
  };
}
