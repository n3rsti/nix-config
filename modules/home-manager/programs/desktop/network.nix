{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.network;
in
{
  options.profile.programs.desktop.network.enable =
    lib.mkEnableOption "network applications and tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      netcat-gnu
      nmap
      qbittorrent
      remmina # Remote Desktop client
      websocat
    ];
  };
}
