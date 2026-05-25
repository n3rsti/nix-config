{
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    unstable.signal-desktop
    bitwarden-desktop
    unstable.freetube

    # dev tools
    opencode
    unstable.devenv
    websocat
    package-version-server
    vhdl-ls
    fixjson
    gh
    postman
    unstable.tree-sitter
    bash-language-server # Bash lsp
    beautysh # Bash formatter
    zed-editor-fhs
    vscode-fhs

    cheese # Camera
    gnome-text-editor
    orca-slicer
    unstable.jellyfin-media-player
    r2modman # mod manager for games

    papers # pdf viewer
    gnome-calendar
    gnome-online-accounts-gtk
    (rofi.override {
      plugins = [ rofi-file-browser ];
    })
    wiremix

    gimp
    unstable.discord
    obs-studio
    unstable.prismlauncher
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
    wineWow64Packages.staging
    winetricks

    nautilus

    swaynotificationcenter

    hyprlock
    swayosd

    waybar
    television # tv
    pavucontrol # Sound gui

    nmgui # Wifi gui
    dunst

    chromium
    ffmpeg_6-full
    eza # better ls
    copyq
    wev # Mouse / keyboard input analyzer
    wl-clipboard # wl-copy
    protonup-ng # Proton utilities
    libnotify # Notification utilities
    hyprpicker # Color picker
    yt-dlp # Downloading videos
    cava # Music visualizer
    grimblast # Screenshot utility
    grim # Utility for grimblast i think
    gnome-clocks
    easyeffects # Sound effects for input/output
    remmina # Remote Desktop client
    mangojuice # Control mangohud
    imagemagick # To show images in neovim

    errands # Task manager
    unstable.protonmail-desktop
    arduino-ide
    stlink # Something for flashing programs to microcontrollers
    # Dictionaries
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US

    leetgo # Leetcode local practice

    wf-recorder # Simple screen recording
    slurp # Area picker for screen recording

    gnome-weather # Weather app
    glib # Needed for gapplication launching like with gnome-weather

    caligula # Flashing ISOs
    localsend # Sending files in local network
    switcheroo # Converting image formats
    foliate # Ebook reader

    unstable.quickshell
    blanket # Sounds
    baobab # Disk usage analyzer

    (heroic.override { extraPkgs = pkgs: [ pkgs.gamescope ]; })
  ];
}
