{
  flake.nixosModules.uptime-kuma = _: {
    services.uptime-kuma = {
      enable = true;
    };

    services.tailscaleServe.apps.uptime-kuma.target = "http://127.0.0.1:3001";
  };
}
