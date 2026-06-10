{ osConfig, lib, ... }:
{
  services.polkit-gnome.enable = true;

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  }
  // lib.optionalAttrs osConfig.programs.hyprland.enable {
    NIXOS_OZONE_WL = "1";
  };
}
