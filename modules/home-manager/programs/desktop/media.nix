{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.media;
in
{
  options.profile.programs.desktop.media.enable = lib.mkEnableOption "media applications";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      blanket # Sounds
      cava # Music visualizer
      easyeffects # Sound effects for input/output
      ffmpeg_6-full
      obs-studio
      pavucontrol # Sound gui
      spotify
      unstable.jellyfin-media-player
      vlc
      wf-recorder # Simple screen recording
      yt-dlp # Downloading videos
    ];
  };
}
