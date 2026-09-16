{
  flake.nixosModules.grafana = { config, ... }: {
    services.grafana = {
      enable = true;

      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;
        };
        security = {
          secret_key = "$__file{${config.sops.secrets.grafana_secret_key.path}}";
        };
      };

      provision = {
        enable = true;

        datasources.settings.datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            url = "http://127.0.0.1:9090";
            isDefault = true;
          }
        ];
      };
    };

    services.tailscaleServe.apps.grafana.target = "http://localhost:3000";

    sops.secrets.grafana_secret_key = {
      owner = "grafana";
      group = "grafana";
      mode = "0400";
    };
  };
}
