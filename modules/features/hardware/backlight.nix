{
  flake.nixosModules.backlight =
    {
      pkgs,
      ...
    }:
    {
      hardware.acpilight.enable = true;

      environment.systemPackages = with pkgs; [
        brightnessctl
      ];
    };
}
