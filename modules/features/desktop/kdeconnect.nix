{
  flake.nixosModules.kdeconnect = _: {
    programs.kdeconnect = {
      enable = true;
    };
  };

  flake.homeModules.kdeconnect = _: {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
