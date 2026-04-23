{
  inputs,
  pkgs,
  ...
}:
let
  pkgs_unstable = import inputs.nixpkgs_unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config = {
      allowUnfree = true;
    };
  };
in
{

  home.packages = with pkgs; [
    zsh
    catppuccin
    catppuccin-gtk

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

    pkgs_unstable.signal-desktop
    bitwarden-desktop
    pkgs_unstable.freetube

    # dev tools
    opencode
    pkgs_unstable.devenv
    websocat
    package-version-server
    vhdl-ls
    fixjson
    gh
    postman
    pkgs_unstable.tree-sitter

    cheese
    gnome-text-editor
    orca-slicer
    zed-editor
    pkgs_unstable.jellyfin-media-player
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
    pkgs_unstable.discord
    pkgs_unstable.lutris
    obs-studio
    pkgs_unstable.prismlauncher
    slack
    qbittorrent
    pkgs_unstable.ghostty
    pkgs_unstable.brave
    feather
    spotify
    vlc
    pkgs_unstable.libreoffice-qt6-fresh
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
  ];
}
