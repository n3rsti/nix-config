{
  flake.homeModules.microcontrollers = { pkgs, ... }: {
    home.packages = with pkgs; [
      arduino-ide
      stlink
    ];
  };
}
