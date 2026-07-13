{
  flake.homeModules.zig =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.dev.zig;
    in
    {
      options.dev.zig = {
        enable = lib.mkEnableOption "Zig development environment";
      };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          zig
          zls
        ];
      };
    };
}
