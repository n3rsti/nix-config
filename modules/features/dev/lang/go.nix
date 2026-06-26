{
  flake.homeModules.go =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.dev.go;
    in
    {
      options.dev.go = {
        enable = lib.mkEnableOption "Golang development environment";
      };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          gopls
          delve
        ];

        programs = {
          go = {
            enable = true;
            telemetry.mode = "off";
          };
        };
      };
    };
}
