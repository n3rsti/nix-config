{
  flake.nixosModules.microcontrollers =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.dev.microcontrollers;
    in
    {
      options.dev.microcontrollers.enable = lib.mkEnableOption "microcontroller development environment";

      config = lib.mkIf cfg.enable {
        services.udev.packages = with pkgs; [
          openocd
          stlink
        ];
      };
    };

  flake.homeModules.microcontrollers =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.dev.microcontrollers;
    in
    {
      options.dev.microcontrollers.enable = lib.mkEnableOption "microcontroller development environment";

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          arduino-ide
          stlink
        ];
      };
    };
}
