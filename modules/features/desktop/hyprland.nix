{ self, ... }:
{
  flake.nixosModules.hyprland =
    {
      pkgs,
      ...
    }:
    {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = pkgs.unstable.hyprland;
      };

      security.polkit.enable = true;
    };

  flake.homeModules.hyprland = {
    imports = [
      self.homeModules.hyprland-tools
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
