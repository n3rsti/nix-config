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
    home.packages = with pkgs; [
      (python3.withPackages (
        ps: with ps; [
          debugpy
          pip
          pygobject3
          dbus-python
        ]
      ))
      basedpyright
      black
    ];

  };
}
