{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.communication;
in
{
  options.profile.programs.desktop.communication.enable =
    lib.mkEnableOption "communication applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      slack
      unstable.discord
      unstable.protonmail-desktop
      unstable.signal-desktop
    ];
  };
}
