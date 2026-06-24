{
  flake.nixosModules.librepods = _: {
    programs.librepods.enable = true;
    hardware.bluetooth = {
      settings = {
        General = {
          DeviceID = "bluetooth:004C:0000:0000";
        };
      };
    };
  };
}
