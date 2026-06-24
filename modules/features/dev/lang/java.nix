{
  flake.homeModules.java =
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
        home.packages = with pkgs; [
          maven
          gradle
          jdk25
          jdt-language-server
          lombok
        ];

        home.sessionVariables = {
          JDTLS_JVM_ARGS = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx8G -Xms512m -javaagent:${pkgs.lombok}/share/java/lombok.jar";
        };
      };
    };
}
