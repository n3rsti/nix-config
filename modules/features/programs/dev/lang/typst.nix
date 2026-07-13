{
  flake.homeModules.typst =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.dev.typst;
    in
    {
      options.dev.typst = {
        enable = lib.mkEnableOption "Typst development environment";
      };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          typst
          tinymist
        ];
      };
    };
}
