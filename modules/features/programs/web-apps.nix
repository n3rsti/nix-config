{
  flake.homeModules.web-apps =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      fetchFavicon =
        {
          name,
          url,
          sha256,
        }:
        let
          sanitized = builtins.replaceStrings [ " " ] [ "-" ] name;
          domain = builtins.head (builtins.match "https://([^/]+).*" url);
          rawIcon = pkgs.fetchurl {
            url = "https://www.google.com/s2/favicons?domain=${domain}&sz=256";
            name = "${sanitized}-favicon.png";
            inherit sha256;
          };
        in
        rawIcon;

      mkWebApp =
        {
          name,
          url,
          sha256,
        }:
        let
          iconPath = fetchFavicon { inherit name url sha256; };
        in
        {
          inherit name;
          exec = "xdg-open ${url}";
          icon = "${iconPath}";
          terminal = false;
          type = "Application";
          categories = [
            "Network"
            "WebBrowser"
          ];
        };

      inherit (config) webApps;
    in
    {
      options.webApps = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
              };

              url = lib.mkOption {
                type = lib.types.str;
              };

              sha256 = lib.mkOption {
                type = lib.types.str;
              };
            };
          }
        );
        default = [ ];
      };

      config.xdg.desktopEntries = builtins.listToAttrs (
        map (app: {
          inherit (app) name;
          value = mkWebApp app;
        }) webApps
      );
    };
}
