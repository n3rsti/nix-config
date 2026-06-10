{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.maker;
in
{
  options.profile.programs.desktop.maker.enable = lib.mkEnableOption "maker applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      caligula # Flashing ISOs
      orca-slicer
    ];
  };
}
