{
  pkgs,
  config,
  ...
}:
{

  services = {
    tailscale.enable = true;

    paperless = {
      enable = true;
      settings = {
        PAPERLESS_URL = "https://paperless.tail3ce7af.ts.net";
      };
    };

    qbittorrent = {
      enable = true;
      webuiPort = 8082;
    };

    nextcloud = {
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

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    immich.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    jellyfin = {
      enable = true;
      package = pkgs.jellyfin;
      group = "media";
    };

    radarr = {
      enable = true;
      group = "media";
    };

    prowlarr = {
      enable = true;
    };

    flaresolverr = {
      package = pkgs.flaresolverr;
      enable = true;
    };

    sonarr = {
      enable = true;
      group = "media";
    };

    bazarr = {
      enable = true;
      group = "media";
    };

    jellyseerr = {
      enable = true;
    };

    uptime-kuma = {
      enable = true;
    };
  };
}
