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
    environment.systemPackages = with pkgs; [
      nix-ld
      nil
      nixfmt
      nixd
    ];

  };
}
