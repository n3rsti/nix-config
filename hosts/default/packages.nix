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
    pkgs_stable.postman
    tree-sitter
    lazygit
    blueprint-compiler

    # apps
    neovim
    pkgs_stable.zed-editor
    jellyfin-media-player
    pkgs_stable.clickup
    r2modman # mod manager for games
    figma-linux
    pkgs_stable.ffmpeg_6-full
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
    pkgs_stable.firefox
    signal-desktop
    bitwarden-desktop
    pkgs_stable.freetube
    pkgs_stable.copyq
    pkgs_stable.gimp
    pkgs_stable.discord
    pkgs_stable.lutris
    obs-studio
    pkgs_stable.prismlauncher
    pkgs_stable.slack
    pkgs_stable.qbittorrent
    ghostty
    pkgs_stable.brave
    feather
    pkgs_stable.spotify
    vlc
    libreoffice-qt6-fresh
    eog
    resources
    pkgs_stable.wine
    pkgs_stable.wine64
    rofimoji
    trayscale
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
