{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.dev.java;
  pkgs_stable = (
    import inputs.nixpkgs_stable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  options.dev.java = {
    enable = lib.mkEnableOption "Java development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs_stable; [
      maven
      gradle
      jdk25
      jdt-language-server
      lombok
    ];

    environment.sessionVariables = {
      JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
  };
}
