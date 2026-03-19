{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.java;
in
{
  options.dev.java = {
    enable = lib.mkEnableOption "Java development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
