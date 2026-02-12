{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.c;
in
{
  options.dev.c = {
    enable = lib.mkEnableOption "C/C++ development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang-tools
      gnumake
      pkg-config

      glsl_analyzer
      bear

    ];

  };
}
