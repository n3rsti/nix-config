{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.kotlin;
in
{
  options.dev.kotlin = {
    enable = lib.mkEnableOption "Kotlin development environment";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kotlin
      kotlin-language-server
      ktlint
      android-studio-full
      androidenv.androidPkgs.platform-tools
      androidenv.androidPkgs.emulator
    ];
  };
}
