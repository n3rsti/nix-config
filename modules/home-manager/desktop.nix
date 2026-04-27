{ osConfig, lib, ... }:
{
  services.polkit-gnome.enable = true;
  services.hyprsunset = lib.mkIf osConfig.programs.hyprland.enable {
    enable = true;
  };

  services.hypridle.enable = osConfig.programs.hyprland.enable;

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  }
  // lib.optionalAttrs osConfig.programs.hyprland.enable {
    NIXOS_OZONE_WL = "1";
  };
}
