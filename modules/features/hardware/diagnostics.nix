{
  flake.nixosModules.diagnostics =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        dmidecode
        usbutils
        vulkan-tools
      ];
    };
}
