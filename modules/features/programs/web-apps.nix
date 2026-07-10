{
  flake.homeModules.web-apps =
    {
      config,
      lib,
      ...
    }:
    let
      mkWebApp =
        {
          name,
          url,
          icon,
        }:
        {
          inherit name;
          exec = "xdg-open ${url}";
          icon = "${icon}";
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

              icon = lib.mkOption {
                type = lib.types.path;
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
