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
      go
      gopls
      delve
    ];

  };
}
