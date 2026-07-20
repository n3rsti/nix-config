{
  flake.nixosModules.attic = { config, ... }: {
    sops.secrets.attic_server_token = { };

    services.postgresql = {
      enable = true;

      ensureDatabases = [
        "atticd"
      ];

      ensureUsers = [
        {
          name = "atticd";
          ensureDBOwnership = true;
        }
      ];
    };

    services.atticd = {
      enable = true;
      environmentFile = config.sops.secrets.attic_server_token.path;

      settings = {
        listen = "0.0.0.0:8083";

        database = {
          url = "postgresql:///atticd?host=/run/postgresql";
        };

        storage = {
          type = "local";
          path = "/var/lib/atticd/storage";
        };

        # Optional but relevant for your large Electron upload issue.
        # Larger chunks reduce chunk/database overhead.
        chunking = {
          nar-size-threshold = 64 * 1024 * 1024;
          min-size = 1 * 1024 * 1024;
          avg-size = 4 * 1024 * 1024;
          max-size = 16 * 1024 * 1024;
        };
      };
    };

    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8083 ];

    services.tailscaleServe.apps.attic.target = "http://localhost:8083";
  };
}
