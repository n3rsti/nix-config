{
  pkgs,
  ...
}:
let
  apps = with pkgs; [
    unstable.signal-desktop
    bitwarden-desktop
    postman
    cheese # Camera
    gnome-text-editor
    orca-slicer
    unstable.jellyfin-media-player
    r2modman # mod manager for games
    papers # pdf viewer
    gnome-calendar
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
    nautilus
    chromium
    copyq
    easyeffects # Sound effects for input/output
    remmina # Remote Desktop client
    errands # Task manager
    unstable.protonmail-desktop
    arduino-ide
    gnome-weather # Weather app
    localsend # Sending files in local network
    switcheroo # Converting image formats
    foliate # Ebook reader
    blanket # Sounds
    baobab # Disk usage analyzer
    gnome-clocks
    (heroic.override { extraPkgs = pkgs: [ pkgs.gamescope ]; })
    pavucontrol # Sound gui
    gnome-online-accounts-gtk
    networkmanagerapplet # For nm-connection-editor
  ];

  cliTools = with pkgs; [
    # dev tools
    unstable.opencode
    unstable.devenv
    websocat
    package-version-server
    vhdl-ls
    fixjson
    gh
    unstable.tree-sitter
    bash-language-server # Bash lsp
    beautysh # Bash formatter
    ffmpeg_6-full
    eza # better ls
    wev # Mouse / keyboard input analyzer
    wl-clipboard # wl-copy
    protonup-ng # Proton utilities
    libnotify # Notification utilities
    hyprpicker # Color picker
    yt-dlp # Downloading videos
    cava # Music visualizer
    grimblast # Screenshot utility
    grim # Utility for grimblast i think
    mangojuice # Control mangohud
    imagemagick # To show images in neovim
    wineWow64Packages.staging
    winetricks
    stlink # Something for flashing programs to microcontrollers
    # Dictionaries
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US

    leetgo # Leetcode local practice
    wf-recorder # Simple screen recording
    slurp # Area picker for screen recording
    caligula # Flashing ISOs
  ];

  desktopIntegration = with pkgs; [
    waybar
    television # tv
    nmgui # Wifi gui
    glib # Needed for gapplication launching like with gnome-weather
    gpu-screen-recorder # For noctalia-shell
  ];
in
{
  home.packages = apps ++ cliTools ++ desktopIntegration;
}
