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
    nixpkgs.config.android_sdk.accept_license = true;

    environment.systemPackages = with pkgs; [
      kotlin
      kotlin-language-server
      ktlint
      android-studio-full
      androidenv.androidPkgs.platform-tools
      androidenv.androidPkgs.emulator
    ];
  };
}
