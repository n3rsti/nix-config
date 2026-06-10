{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.cli.desktop;
in
{
  options.profile.programs.cli.desktop.enable = lib.mkEnableOption "desktop command-line tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      grim # Utility for grimblast i think
      grimblast # Screenshot utility
      hyprpicker # Color picker
      libnotify # Notification utilities
      slurp # Area picker for screen recording
      wev # Mouse / keyboard input analyzer
      wl-clipboard # wl-copy
    ];
  };
}
