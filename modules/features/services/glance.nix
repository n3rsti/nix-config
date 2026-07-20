{
  flake.nixosModules.glance =
    { config, ... }:

    {
      sops.secrets.immich_api_key = {
        restartUnits = [ "glance.service" ];
      };

      services.glance = {
        enable = true;

        settings = {
          server = {
            host = "127.0.0.1";
            port = 8085;
          };

          pages = [
            {
              name = "Home";

              columns = [
                {
                  size = "small";

                  widgets = [
                    {
                      type = "custom-api";
                      title = "Immich stats";
                      cache = "1d";

                      url = "https://immich.tail3ce7af.ts.net/api/server/statistics";

                      headers = {
                        "x-api-key" = {
                          _secret = config.sops.secrets.immich_api_key.path;
                        };

                        Accept = "application/json";
                      };

                      template = ''
                        <div class="flex justify-between text-center">
                          <div>
                            <div class="color-highlight size-h3">
                              {{ .JSON.Int "photos" | formatNumber }}
                            </div>
                            <div class="size-h6">PHOTOS</div>
                          </div>

                          <div>
                            <div class="color-highlight size-h3">
                              {{ .JSON.Int "videos" | formatNumber }}
                            </div>
                            <div class="size-h6">VIDEOS</div>
                          </div>

                          <div>
                            <div class="color-highlight size-h3">
                              {{ div (.JSON.Int "usage" | toFloat) 1073741824 | toInt | formatNumber }}GB
                            </div>
                            <div class="size-h6">USAGE</div>
                          </div>
                        </div>
                      '';
                    }
                  ];
                }
                {

                  size = "full";

                  widgets = [
                    {

                      type = "monitor";
                      title = "Services";
                      cache = "1m";
                      sites = [
                        {
                          title = "Immich";
                          url = "https://immich.tail3ce7af.ts.net/";
                          check-url = "https://immich.tail3ce7af.ts.net/";
                          icon = "di:immich";
                        }

                        {
                          title = "Pi-hole";
                          url = "https://pihole.tail3ce7af.ts.net/";
                          check-url = "https://pihole.tail3ce7af.ts.net/";
                          icon = "di:pi-hole";
                        }

                        {
                          title = "Nextcloud";
                          url = "https://nextcloud.tail3ce7af.ts.net/";
                          check-url = "https://nextcloud.tail3ce7af.ts.net/";
                          icon = "di:nextcloud";
                        }

                        {
                          title = "qBittorrent";
                          url = "https://qbittorrent.tail3ce7af.ts.net/";
                          check-url = "https://qbittorrent.tail3ce7af.ts.net/";
                          icon = "di:qbittorrent";
                        }

                        {
                          title = "Paperless";
                          url = "https://paperless.tail3ce7af.ts.net/";
                          check-url = "https://paperless.tail3ce7af.ts.net/";
                          icon = "di:paperless-ngx";
                        }

                        {
                          title = "Attic";
                          url = "https://attic.tail3ce7af.ts.net/";
                          check-url = "https://attic.tail3ce7af.ts.net/";
                          icon = "sh:attic";
                        }

                      ];
                    }

                    {

                      type = "monitor";
                      title = "Media";
                      cache = "1m";
                      sites = [

                        {
                          title = "Jellyfin";
                          url = "https://jellyfin.tail3ce7af.ts.net/";
                          check-url = "https://jellyfin.tail3ce7af.ts.net/";
                          icon = "di:jellyfin";
                        }

                        {
                          title = "Jellyseer";
                          url = "https://jellyseerr.tail3ce7af.ts.net/";
                          check-url = "https://jellyseerr.tail3ce7af.ts.net/";
                          icon = "di:jellyseerr";
                        }

                        {
                          title = "Radarr";
                          url = "https://radarr.tail3ce7af.ts.net/";
                          check-url = "https://radarr.tail3ce7af.ts.net/";
                          icon = "di:radarr";
                        }

                        {
                          title = "Sonarr";
                          url = "https://sonarr.tail3ce7af.ts.net/";
                          check-url = "https://sonarr.tail3ce7af.ts.net/";
                          icon = "di:sonarr";
                        }

                        {
                          title = "Prowlarr";
                          url = "https://prowlarr.tail3ce7af.ts.net/";
                          check-url = "https://prowlarr.tail3ce7af.ts.net/";
                          icon = "di:prowlarr";
                        }

                        {
                          title = "Bazarr";
                          url = "https://bazarr.tail3ce7af.ts.net/";
                          check-url = "https://bazarr.tail3ce7af.ts.net/";
                          icon = "di:bazarr";
                        }

                      ];
                    }
                  ];

                }
              ];
            }
          ];
        };
      };

      services.tailscaleServe.apps.glance.target = "http://localhost:8085";
    };
}
