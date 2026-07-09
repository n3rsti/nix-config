{
  flake.nixosModules.attic = { config, ... }: {

    sops.secrets.attic_server_token = { };

    services.atticd = {
      enable = true;
      environmentFile = "/run/secrets/attic_server_token";
      settings = {
        listen = "0.0.0.0:8083";
        storage = {
          type = "local";
          path = "/var/lib/atticd/storage";
        };
      };
    };
    networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8083 ];
  };
}
