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
    environment.systemPackages = with pkgs; [
      typst
      tinymist
    ];

  };
}
