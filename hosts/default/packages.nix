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
    neovim
    devenv
    bun
    typst
    tinymist
    websocat
    pkgs_stable.roslyn-ls
    basedpyright
    black
    deno
    gcc
    gopls
    delve # go debugger
    stylua
    clang-tools
    lua-language-server
    pkgs_stable.dotnet-sdk_9
    pkgs_stable.csharp-ls
    rust-analyzer
    rustup
    prettierd
    package-version-server
    nil
    nixfmt
    bear
    python3
    python3Packages.pygobject3
    typescript-language-server
    glsl_analyzer
    vhdl-ls
    nodePackages.vscode-json-languageserver
    vscode-langservers-extracted
    fixjson
    tailwindcss-language-server
    nixd
    go
    gnumake
    pkg-config
    nodejs_24
    eslint
    zed-editor
    typescript
    gh
    lua51Packages.tiktoken_core
    postman
    go-blueprint
    python313Packages.pip
    nix-ld
    python313Packages.cssbeautifier
    python313Packages.jsbeautifier
    python313Packages.dbus-python
    lua54Packages.luarocks
    tree-sitter
    lua
    lazygit
    postgres-language-server
    blueprint-compiler

    # apps
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
