{
  flake.nixosModules.uptime-kuma = _: {
    services.uptime-kuma = {
      enable = true;
    };
  };
}
