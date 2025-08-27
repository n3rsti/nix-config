{
  pkgs,
  config,
  inputs,
  ...
}:
let
  pkgs_stable = (
    import inputs.nixpkgs_25_05 {
      inherit (pkgs) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    # dev tools
    pkgs.neovim
    pkgs.deno
    pkgs.gcc
    pkgs.gopls
    pkgs.stylua
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.cargo
    pkgs.rust-analyzer
    pkgs.rustup
    pkgs.prettierd
    pkgs.package-version-server
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.bear
    pkgs.python3
    pkgs.python3Packages.pygobject3
    pkgs.R
    pkgs.rPackages.languageserversetup
    pkgs.rPackages.languageserver
    pkgs.air-formatter
    pkgs.typescript-language-server
    pkgs.glsl_analyzer
    pkgs.vhdl-ls
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.vscode-langservers-extracted
    pkgs.fixjson
    pkgs.tailwindcss-language-server
    pkgs.nixd
    pkgs.go
    pkgs.gnumake
    pkgs.glew
    pkgs.glfw
    pkgs.pkg-config
    pkgs.glm
    pkgs.nodejs_24
    pkgs.zed-editor-fhs_git
    pkgs.typescript
    pkgs.jdt-language-server
    pkgs.lombok
    pkgs.gh
    pkgs.lua51Packages.tiktoken_core
    pkgs.postman
    pkgs.go-blueprint
    pkgs.python313Packages.pip
    pkgs.nix-ld
    pkgs.python313Packages.cssbeautifier
    pkgs.python313Packages.jsbeautifier

    # apps
    pkgs.kitty
    pkgs.gnome-calendar
    pkgs.gnome-online-accounts
    gnome-online-accounts-gtk
    # pkgs.rofi-wayland
    (pkgs.rofi-wayland.override {
      plugins = [ rofi-file-browser ];
    })
    pkgs.walker
    pkgs.wiremix
    pkgs.firefox
    pkgs.signal-desktop
    pkgs.bitwarden-desktop
    pkgs.freetube
    pkgs.spotify
    pkgs.discord
    pkgs.copyq
    pkgs_stable.gimp
    pkgs.legcord
    pkgs.path-of-building
    pkgs.lutris
    pkgs.obs-studio
    pkgs_stable.prismlauncher
    pkgs.slack
    pkgs.qbittorrent
    pkgs.ghostty
    pkgs.brave
    # pkgs.jellyfin-media-player
    pkgs.feather
    pkgs.vlc
    pkgs.libreoffice-qt6-fresh
    pkgs.eog
    pkgs.resources
    inputs.zen-browser.packages."${system}".default
    pkgs.wine
    pkgs.wine64
    pkgs.rofimoji
    pkgs.trayscale
    pkgs.lynx
    pkgs.chromium
    pkgs.quickshell
    pkgs.nautilus
    pkgs.monero-gui

    # system
    pkgs.swayosd
    pkgs.hyprpaper
    pkgs.ripgrep
    pkgs_stable.waybar
    pkgs.television
    pkgs.zsh-autosuggestions
    pkgs.kitty-themes
    pkgs.pavucontrol
    pkgs.wl-clipboard
    pkgs.nwg-look
    pkgs.dmidecode
    pkgs.protonup
    pkgs.wget
    pkgs.dunst
    pkgs.libnotify
    pkgs.networkmanagerapplet
    pkgs.tree
    pkgs.acpi
    pkgs.btop
    pkgs.blueberry
    pkgs.networkmanager_dmenu
    pkgs.pinentry-gnome3
    pkgs.hyprpicker
    pkgs.grim
    pkgs.fzf
    # pkgs.tmux-sessionizer
    pkgs.tmux
    pkgs.unzip
    pkgs.fastfetch
    pkgs.imagemagick
    pkgs.chafa
    pkgs.nmap
    pkgs.zip
    pkgs.hyprsunset
    pkgs.yt-dlp
    pkgs.cava
    pkgs.lolcat
    pkgs.pipes
    pkgs.cmatrix
    pkgs.firejail
    pkgs.gif-for-cli
    pkgs.tty-clock
    pkgs.grimblast # screenshot utility
    pkgs.lsof
    pkgs.netcat-gnu
    pkgs.jq
    pkgs.rippkgs
    # pkgs.qt5.full
    # pkgs.kdePackages.qtdeclarative
    pkgs.bc
    pkgs.playerctl

    # disk formatting, used for microsd
    pkgs.fd
    pkgs.parted
    pkgs.exfatprogs
    pkgs.gnome-disk-utility
  ];
}
