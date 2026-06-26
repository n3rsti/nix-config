{
  flake.nixosModules.nextcloud =
    {
      pkgs,
      config,
      ...
    }:
    {
      services.nextcloud = {
        enable = true;
        https = true;
        package = pkgs.nextcloud33;
        hostName = "nextcloud.tail3ce7af.ts.net";
        config.adminpassFile = "/run/secrets/nextcloud-admin-pass";
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
    };
}
