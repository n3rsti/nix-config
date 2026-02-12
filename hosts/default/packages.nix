{
  pkgs,
  config,
  inputs,
  ...
}:
let
  pkgs_stable = (
    import inputs.nixpkgs_stable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    # dev tools
    opencode
    devenv
    websocat
    package-version-server
    vhdl-ls
    fixjson
    gh
    postman
    tree-sitter
    lazygit
    blueprint-compiler

    # apps
    neovim
    zed-editor
    jellyfin-media-player
    pkgs_stable.clickup
    r2modman # mod manager for games
    figma-linux
    ffmpeg_6-full
    arkenfox-userjs
    pkgs_stable.freecad
    eza
    thunderbird
    evince # pdf viewer
    gnome-weather
    gnome-calendar
    gnome-online-accounts
    gnome-online-accounts-gtk
    (pkgs_stable.rofi.override {
      plugins = [ pkgs_stable.rofi-file-browser ];
    })
    wiremix
    firefox
    signal-desktop
    bitwarden-desktop
    freetube
    pkgs_stable.copyq
    pkgs_stable.gimp
    legcord
    discord
    pkgs_stable.lutris
    obs-studio
    pkgs_stable.prismlauncher
    slack
    qbittorrent
    ghostty
    brave
    feather
    spotify
    vlc
    libreoffice-qt6-fresh
    eog
    resources
    wine
    wine64
    rofimoji
    trayscale
    chromium
    quickshell
    pkgs_stable.nautilus

    # system
    swaynotificationcenter
    duf
    libimobiledevice
    hyprlock
    swayosd
    cairo
    poppler_gi
    gtk4-layer-shell
    wev
    hyprpaper
    ripgrep
    pkgs_stable.waybar
    television
    zsh-autosuggestions
    pavucontrol
    wl-clipboard
    dmidecode
    protonup-ng
    wget
    dunst
    libnotify
    networkmanagerapplet
    nmgui
    tree
    acpi
    btop
    blueberry
    pinentry-gnome3
    hyprpicker
    grim
    fzf
    tmux
    fastfetch
    imagemagick
    chafa
    nmap
    zip
    unzip
    hyprsunset
    yt-dlp
    cava
    lolcat
    pipes
    cmatrix
    firejail
    gif-for-cli
    tty-clock
    grimblast # screenshot utility
    lsof
    netcat-gnu
    jq
    rippkgs
    kdePackages.qtdeclarative
    kdePackages.kdeconnect-kde
    bc

    adwaita-qt6

    # disk formatting, used for microsd
    fd
    parted
    exfatprogs
    gnome-disk-utility
  ];
}
