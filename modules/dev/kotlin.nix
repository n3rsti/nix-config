{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.dev.kotlin;
  pkgs_stable = (
    import inputs.nixpkgs_stable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  options.dev.kotlin = {
    enable = lib.mkEnableOption "Kotlin development environment";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.android_sdk.accept_license = true;

    environment.systemPackages = with pkgs_stable; [
      kotlin
      kotlin-language-server
      ktlint
      android-studio
      androidenv.androidPkgs.platform-tools
      androidenv.androidPkgs.emulator
    ];

    environment.sessionVariables = {
      JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
  };
}
