{
  flake.nixosModules.arr =
    {
      pkgs,
      ...
    }:
    {
      services = {
        jellyfin = {
          enable = true;
          package = pkgs.jellyfin;
          group = "media";
        };

        radarr = {
          enable = true;
          group = "media";
        };

        sonarr = {
          enable = true;
          group = "media";
        };

        bazarr = {
          enable = true;
          group = "media";
        };

        seerr = {
          enable = true;
        };

        qbittorrent = {
          enable = true;
          group = "media";
          webuiPort = 8082;
          serverConfig = {
            Preferences.Downloads = {
              SavePath = "/srv/media/torrents";
              TempPath = "/srv/media/torrents/incomplete";
              TempPathEnabled = true;
            };
            Preferences.Connection = {
              Interface = "tailscale0";
              InterfaceName = "tailscale0";
            };
          };
        };

        tailscaleServe.apps = {
          bazarr.target = "http://127.0.0.1:6767";
          jellyfin.target = "http://127.0.0.1:8096";
          jellyseerr.target = "http://127.0.0.1:5055";
          qbittorrent.target = "http://127.0.0.1:8082";
          radarr.target = "http://127.0.0.1:7878";
          sonarr.target = "http://127.0.0.1:8989";
        };
      };

      systemd.services.qbittorrent.unitConfig.RequiresMountsFor = [ "/srv/media/torrents" ];

    };

  flake.nixosModules.flaresolverr = { pkgs, ... }: {
    services.flaresolverr = {
      package = pkgs.flaresolverr;
      enable = true;
    };
  };

  flake.nixosModules.prowlarr = {
    services = {
      prowlarr = {
        enable = true;
      };

      tailscaleServe.apps = {
        prowlarr.target = "http://127.0.0.1:9696";
      };
    };
  };
}
