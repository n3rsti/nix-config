{
  flake.nixosModules.rgb =
    {
      pkgs,
      ...
    }:
    {
      services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb;
      };

      environment.systemPackages = with pkgs; [
        openrgb
      ];

      # You can disable the device in /var/lib/OpenRGB/OpenRGB.json
    };
}
