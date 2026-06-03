{
  lib,
  pkgs,
  config,
  ...
}:
{
  services = {

    tailscale = lib.mkIf config.services.tailscale.enable {
      serve = {
        enable = true;
        services = {
          bazarr = {
            endpoints = {
              "tcp:443" = "http://localhost:6767";
            };
          };
          jellyfin = {
            endpoints = {
              "tcp:443" = "http://localhost:8096";
            };
          };
          jellyseerr = {
            endpoints = {
              "tcp:443" = "http://localhost:5055";
            };
          };
          prowlarr = {
            endpoints = {
              "tcp:443" = "http://localhost:9696";
            };
          };
          qbittorrent = {
            endpoints = {
              "tcp:443" = "http://localhost:8082";
            };
          };
          radarr = {
            endpoints = {
              "tcp:443" = "http://localhost:7878";
            };
          };
          sonarr = {
            endpoints = {
              "tcp:443" = "http://localhost:8989";
            };
          };
        };
      };

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

    qbittorrent = {
      endpoints = {
        "tcp:443" = "http://localhost:8082";
      };
    };
  };

}
