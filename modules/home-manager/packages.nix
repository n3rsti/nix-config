{
  inputs,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    zsh
    catppuccin
    catppuccin-gtk

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

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

    cheese
    gnome-text-editor
    orca-slicer
    zed-editor-fhs
    vscode-fhs
    unstable.jellyfin-media-player
    r2modman # mod manager for games
    figma-linux

    thunderbird
    papers # pdf viewer
    gnome-weather
    gnome-calendar
    gnome-online-accounts-gtk
    (rofi.override {
      plugins = [ rofi-file-browser ];
    })
    wiremix

    gimp
    unstable.discord
    unstable.lutris
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
    wineWow64Packages.stable

    nautilus

    swaynotificationcenter

    hyprlock
    swayosd

    waybar
    television
    pavucontrol

    nmgui
    dunst

    chromium
    ffmpeg_6-full
    eza
    copyq
    wev
    wl-clipboard
    protonup-ng
    libnotify
    hyprpicker
    grim
    hyprsunset
    yt-dlp
    cava
    grimblast
    rippkgs
    gnome-clocks
    easyeffects
    remmina
    mangohud
    mangojuice
    imagemagick

    errands
    unstable.protonmail-desktop
    arduino-ide
    stlink
  ];
}
