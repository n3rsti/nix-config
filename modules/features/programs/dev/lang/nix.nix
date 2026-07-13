{
  flake.homeModules.nix =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.dev.nix;
    in
    {
      options.dev.nix = {
        enable = lib.mkEnableOption "Nix development environment";
      };

      config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [
          nil
          nixfmt
          nixd
        ];
      };
    };
}
