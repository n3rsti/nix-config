{ pkgs, ... }:
{
  home.packages = with pkgs; [
    glib # Needed for gapplication launching like with gnome-weather
  ];
}
