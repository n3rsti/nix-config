{
  flake.homeModules.java = { pkgs, ... }: {
    home.packages = with pkgs; [
      maven
      jdt-language-server
      lombok
    ];

    programs = {
      java = {
        enable = true;
        package = pkgs.jdk25;
      };
      gradle.enable = true;
    };

    home.sessionVariables = {
      JDTLS_JVM_ARGS = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx8G -Xms512m -javaagent:${pkgs.lombok}/share/java/lombok.jar";
    };
  };
}
