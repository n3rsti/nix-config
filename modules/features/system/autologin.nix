{
  flake.nixosModules.autologin = _: {
    services.displayManager.autoLogin = {
      enable = true;
      user = "n3rsti";
    };
  };
}
