{
  flake.nixosModules.systemd-boot =
    { pkgs, ... }:
    {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      environment.systemPackages = with pkgs; [
        efibootmgr
      ];
    };
}
