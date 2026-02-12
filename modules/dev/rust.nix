{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.rust;
in
{
  options.dev.rust = {
    enable = lib.mkEnableOption "Rust development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rust-analyzer
      rustup
    ];

  };
}
