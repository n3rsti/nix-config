{
  flake.homeModules.microcontrollers = { pkgs, ... }: {
    home.packages = with pkgs; [
      arduino-ide
      stlink
    ];
  };
  flake.nixosModules.microcontrollers = { pkgs, ... }: {
    services.udev.packages = with pkgs; [
      openocd
      stlink
    ];
  };
}
