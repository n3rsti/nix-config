{
  flake.homeModules.c =
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
        home.packages = with pkgs; [
          gcc
          clang-tools
          gnumake
          pkg-config
          glsl_analyzer
          bear
        ];

      };
    };
}
