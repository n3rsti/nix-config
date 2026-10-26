{
  flake.nixosModules.searx = { config, pkgs, ... }: {
    sops.secrets.searxng_secret = { };

    sops.templates."searxng.env" = {
      owner = "searx";
      content = ''
        SEARXNG_SECRET=${config.sops.placeholder.searxng_secret}
      '';
    };

    services = {
      searx = {
        enable = true;
        package = pkgs.unstable.searxng;

        environmentFile = config.sops.templates."searxng.env".path;

        settings = {
          general.enable_metrics = false;

          server = {
            secret_key = "$SEARXNG_SECRET";
            image_proxy = true;
          };
        };
      };

      tailscaleServe.apps = {
        searxng.target = "http://127.0.0.1:8888";
      };
    };
  };
}
