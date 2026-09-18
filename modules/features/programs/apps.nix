{ self, ... }:
{
  flake.homeModules.apps =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.homeModules.ghostty
      ];

      home.packages = with pkgs; [
        # General
        snapshot # Camera
        copyq
        loupe # Image viewer
        showtime # Video player
        gnome-online-accounts-gtk
        gnome-contacts
        gnome-music
        unstable.bitwarden-desktop
        errands # Task manager
        gnome-calendar
        gnome-clocks
        gnome-weather # Weather app
        gnome-maps
        gnome-calculator

        # Communication
        slack
        unstable.protonmail-desktop
        unstable.signal-desktop

        # Documents
        gimp
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pl_PL
        papers # pdf viewer
        poppler-utils
        unstable.libreoffice

        # Files
        baobab # Disk usage analyzer
        gnome-disk-utility # Disks
        resources
        gnome-text-editor
        switcheroo # Converting image formats
        (nautilus.overrideAttrs (old: {
          buildInputs =
            old.buildInputs
            ++ (with gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
              gst-plugins-ugly
              gst-libav
            ]);
        }))

        # Maker
        caligula # Flashing ISOs
        orca-slicer

        # Media
        blanket # Sounds
        easyeffects # Sound effects for input/output
        ffmpeg_6-full
        pavucontrol # Sound gui
        spotify
        unstable.jellyfin-media-player
        vlc
        mpv # Video player for other unsupported formats
        wf-recorder # Simple screen recording
        qbittorrent
      ];

      programs = {
        # Browsers
        brave = {
          enable = true;
          package = pkgs.unstable.brave;
        };
        chromium.enable = true;
        firefox = {
          enable = true;
          package = pkgs.unstable.firefox;

          configPath = "${config.xdg.configHome}/mozilla/firefox";
          profiles.default = {
            isDefault = true;
            search = {
              default = lib.mkDefault "ddg";
              privateDefault = lib.mkDefault "ddg";
            };
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
              bitwarden
              darkreader
              return-youtube-dislikes
              sponsorblock
              ublock-origin
              youtube-shorts-block
            ];
          };
        };

        # Communication
        discord = {
          enable = true;
          package = pkgs.unstable.discord;
        };

        # Documents
        onlyoffice.enable = true;
        foliate.enable = true; # Ebook reader

        # Media
        obs-studio.enable = true;
        yt-dlp.enable = true; # Downloading videos
        cava.enable = true; # Audio visualizer
      };

      xdg = {
        autostart = {
          enable = true;
          entries = [
            "${pkgs.signal-desktop}/share/applications/signal.desktop"
          ];
        };

        desktopEntries.bitwarden = {
          name = "Bitwarden";
          comment = "Secure and free password manager for all of your devices";
          exec = "env XDG_CURRENT_DESKTOP=KDE ${pkgs.unstable.bitwarden-desktop}/bin/bitwarden %U";
          icon = "bitwarden";
          type = "Application";
          categories = [ "Utility" ];
          mimeType = [ "x-scheme-handler/bitwarden" ];
        };
      };
    };
}
