{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.dev.kotlin;
  pkgs_unstable = (
    import inputs.nixpkgs_unstable {
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

    environment.systemPackages = with pkgs; [
      kotlin
      kotlin-language-server
      ktlint
      pkgs_unstable.android-studio-full
      androidenv.androidPkgs.platform-tools
      androidenv.androidPkgs.emulator
    ];

    environment.sessionVariables = {
      JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
  };
}
