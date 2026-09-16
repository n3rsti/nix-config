{
  flake.nixosModules.prometheus = { config, ... }: {
    services.prometheus = {
      enable = true;
      globalConfig.scrape_interval = "15s";
      exporters.node = {
        enable = true;
        port = 9100;

        enabledCollectors = [
          "systemd"
        ];
      };
      scrapeConfigs = [
        {
          job_name = "node";

          static_configs = [
            {
              targets = [
                "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
              ];
            }
          ];
        }
        {
          job_name = "immich-api";

          static_configs = [
            {
              targets = [ "127.0.0.1:8081" ];
            }
          ];
        }

        {
          job_name = "immich-microservices";

          static_configs = [
            {
              targets = [ "127.0.0.1:8082" ];
            }
          ];
        }
      ];
    };
  };
}
