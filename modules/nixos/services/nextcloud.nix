{
  pkgs,
  config,
  lib,
  ...
}:
{

  services.nextcloud = {
    enable = true;
    https = true;
    package = pkgs.nextcloud33;
    hostName = "nextcloud.tail3ce7af.ts.net";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings.trusted_domains = [
      "localhost"
      "server.tail3ce7af.ts.net"
      "nextcloud.tail3ce7af.ts.net"
      "100.72.98.44"
    ];
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
    };
    extraAppsEnable = true;
    configureRedis = true;
  };

  services.tailscale = lib.mkIf config.services.tailscale.enable {
    serve = {
      enable = true;
      services = {
        nextcloud = {
          endpoints = {
            "tcp:443" = "http://localhost:80";
          };
        };
      };
    };
  };
}
