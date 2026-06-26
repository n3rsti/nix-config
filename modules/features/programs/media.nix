{
  flake.homeModules.media =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        blanket # Sounds
        easyeffects # Sound effects for input/output
        ffmpeg_6-full
        pavucontrol # Sound gui
        spotify
        unstable.jellyfin-media-player
        vlc
        wf-recorder # Simple screen recording
      ];

      programs = {
        obs-studio.enable = true;
        yt-dlp.enable = true; # Downloading videos
        cava.enable = true; # Audio visualizer
      };
    };
}
