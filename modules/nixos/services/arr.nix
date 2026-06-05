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

    seerr = {
      enable = true;
    };

    qbittorrent = {
      enable = true;
      webuiPort = 8082;
    };
  };

}
