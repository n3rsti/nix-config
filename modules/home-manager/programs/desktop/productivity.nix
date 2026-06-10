{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.productivity;
in
{
  options.profile.programs.desktop.productivity.enable =
    lib.mkEnableOption "productivity applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      errands # Task manager
      gnome-calendar
      gnome-clocks
      gnome-weather # Weather app
    ];
  };
}
