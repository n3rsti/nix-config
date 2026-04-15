{
  pkgs,
  config,
  inputs,
  ...
}:
let
  pkgs_unstable = (
    import inputs.nixpkgs_unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    chromium
    # dev tools
    opencode
    devenv
    websocat
    package-version-server
    vhdl-ls
    fixjson
    gh
    postman
    pkgs_unstable.tree-sitter
    lazygit
    blueprint-compiler

    # apps
    bambu-studio
    neovim
    zed-editor
    pkgs_unstable.jellyfin-media-player
    r2modman # mod manager for games
    figma-linux
    ffmpeg_6-full
    pkgs_unstable.freecad
    eza # ls replacement
    thunderbird
    evince # pdf viewer
    gnome-weather
    gnome-calendar
    gnome-online-accounts-gtk
    (rofi.override {
      plugins = [ rofi-file-browser ];
    })
    wiremix
    pkgs_unstable.arkenfox-userjs
    pkgs_unstable.signal-desktop
    bitwarden-desktop
    pkgs_unstable.freetube
    copyq
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
    trayscale
    quickshell
    nautilus

    # system
    swaynotificationcenter
    duf
    libimobiledevice
    hyprlock
    swayosd
    cairo
    poppler_gi
    poppler-utils # pdftotext
    gtk4-layer-shell
    wev
    ripgrep
    waybar
    television
    pavucontrol
    wl-clipboard
    dmidecode
    protonup-ng
    wget
    dunst
    libnotify
    nmgui
    tree
    acpi
    btop
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
    gnome-clocks

    # disk formatting, used for microsd
    fd
    parted
    exfatprogs
    gnome-disk-utility
    usbutils

    easyeffects
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

    polkit_gnome
    snx-rs # vpn
    remmina # rdp client
    system-config-printer
    vulkan-tools
    mangohud
    mangojuice
  ];
}
