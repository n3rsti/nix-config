{
  pkgs,
  ...
}:
let
  apps = with pkgs; [
    unstable.signal-desktop
    unstable.bitwarden-desktop
    postman
    cheese # Camera
    gnome-text-editor
    orca-slicer
    unstable.jellyfin-media-player
    papers # pdf viewer
    gnome-calendar
    gimp
    unstable.discord
    obs-studio
    slack
    qbittorrent
    unstable.ghostty
    unstable.brave
    feather
    spotify
    vlc
    unstable.libreoffice-qt6-fresh
    eog
    resources
    nautilus
    chromium
    copyq
    easyeffects # Sound effects for input/output
    remmina # Remote Desktop client
    errands # Task manager
    unstable.protonmail-desktop
    arduino-ide
    gnome-weather # Weather app
    switcheroo # Converting image formats
    foliate # Ebook reader
    blanket # Sounds
    baobab # Disk usage analyzer
    gnome-clocks
    pavucontrol # Sound gui
    gnome-online-accounts-gtk
    networkmanagerapplet # For nm-connection-editor
  ];

  cliTools = with pkgs; [
    # dev tools
    unstable.devenv
    websocat
    fixjson
    unstable.tree-sitter
    bash-language-server # Bash lsp
    beautysh # Bash formatter
    ffmpeg_6-full
    eza # better ls
    wev # Mouse / keyboard input analyzer
    wl-clipboard # wl-copy
    libnotify # Notification utilities
    hyprpicker # Color picker
    yt-dlp # Downloading videos
    cava # Music visualizer
    grimblast # Screenshot utility
    grim # Utility for grimblast i think
    imagemagick # To show images in neovim
    stlink # Something for flashing programs to microcontrollers
    # Dictionaries
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US

    leetgo # Leetcode local practice
    wf-recorder # Simple screen recording
    slurp # Area picker for screen recording
    caligula # Flashing ISOs
    ddcutil # Monitor brightness
  ];

  desktopIntegration = with pkgs; [
    television # tv
    nmgui # Wifi gui
    glib # Needed for gapplication launching like with gnome-weather
  ];
in
{
  home.packages = apps ++ cliTools ++ desktopIntegration;
}
