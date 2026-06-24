{
  flake.nixosModules.gdm = _: {
    services.displayManager.gdm = {
      enable = true;
    };
  };
}
