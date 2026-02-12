{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.python;
in
{
  options.dev.python = {
    enable = lib.mkEnableOption "Python development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      basedpyright
      black

      python313Packages.pip
      python3Packages.pygobject3
      python313Packages.dbus-python
    ];

  };
}
