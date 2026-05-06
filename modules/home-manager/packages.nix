{
  inputs,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
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

    thunderbird
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
    yt-dlp
    cava
    grimblast
    rippkgs
    gnome-clocks
    easyeffects
    remmina # Remote Desktop client
    mangojuice
    imagemagick

    errands
    unstable.protonmail-desktop
    arduino-ide
    stlink
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US
    leetgo # Leetcode local practice

    # Simple screen recording
    wf-recorder
    slurp
    bash-language-server
    beautysh
  ];
}
