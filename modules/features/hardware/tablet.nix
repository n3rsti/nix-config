{
  flake.nixosModules.tablet = _: {
    hardware.opentabletdriver.enable = true;
  };
}
