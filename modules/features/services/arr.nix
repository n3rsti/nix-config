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
          webuiPort = 8082;
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
