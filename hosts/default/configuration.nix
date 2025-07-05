# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:
let
  pkgs_stable = (import inputs.nixpkgs_25_05 {
    inherit (pkgs) system;
    config = config.nixpkgs.config;
  });
in {
  imports = [ # Include the results of the hardware scan.
    ../../modules/nixos/main-user.nix
    inputs.home-manager.nixosModules.default
  ];

  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "n3rsti" = { pkgs, ... }: {
        imports = [ ./home.nix ];
        home.pointerCursor = {
          gtk.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 16;
        };

        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            # Web-related
            "text/html" = "librewolf.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";

            # Image MIME types for Eye of GNOME
            "image/png" = "eog.desktop";
            "image/jpeg" = "eog.desktop";
            "image/jpg" = "eog.desktop";
            "image/gif" = "eog.desktop";
            "image/webp" = "eog.desktop";
            "image/bmp" = "eog.desktop";
            "image/tiff" = "eog.desktop";
          };
        };

      };
    };
    # This allows specific host configurations to override home-manager settings
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  main-user.enable = true;
  main-user.userName = "n3rsti";
  programs.zsh.enable = true;

  home-manager.backupFileExtension = "backup";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = lib.mkDefault "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.enp34s0 = { wakeOnLan.enable = true; };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
    LM_LICENSE_FILE = "\${HOME}/Downloads/license.dat";
  };
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,pl";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pulseaudio.enable = false;

  nix.settings.max-jobs = lib.mkDefault 8;
  nix.settings.cores = 0;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n3rsti = {
    isNormalUser = true;
    description = "n3rsti";
    extraGroups = [ "networkmanager" "wheel" "networkmanager" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.nix-ld.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.auto-optimise-store = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.neovim
    pkgs.kitty
    pkgs.rofi-wayland
    pkgs.firefox
    pkgs.hyprpaper
    pkgs.signal-desktop
    pkgs.gcc
    pkgs.gopls
    pkgs.stylua
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.ripgrep
    pkgs.cargo
    pkgs.bitwarden-desktop
    pkgs.waybar
    pkgs.nixd
    pkgs.television
    pkgs.zsh-autosuggestions
    pkgs.kitty-themes
    pkgs.arduino-ide
    pkgs.pavucontrol
    pkgs.freetube
    pkgs.spotify
    pkgs.discord
    pkgs.copyq
    pkgs.wl-clipboard
    pkgs.nwg-look
    pkgs.prettierd
    pkgs.gimp
    pkgs.zed-editor-fhs
    pkgs.go
    pkgs.dmidecode
    pkgs.protonup
    pkgs.legcord
    pkgs.gnumake
    pkgs.glew
    pkgs.glfw
    pkgs.pkg-config
    pkgs.glm
    pkgs.bear
    pkgs.package-version-server
    pkgs.nil
    pkgs.nixfmt-classic
    pkgs.path-of-building
    pkgs.lutris
    pkgs.wget
    pkgs.obs-studio
    pkgs.prismlauncher
    pkgs.slack
    pkgs.dunst
    pkgs.libnotify
    pkgs.networkmanagerapplet
    pkgs.tree
    pkgs.acpi
    pkgs.python3
    pkgs.btop
    pkgs.overskride
    pkgs.blueberry
    # pkgs.hyprshade
    pkgs.brightnessctl
    pkgs.networkmanager_dmenu
    python3Packages.pygobject3
    pkgs.pinentry-gnome3
    pkgs.qbittorrent
    pkgs.hyprpicker
    pkgs.grim
    pkgs.slurp
    pkgs.R
    pkgs.rPackages.languageserversetup
    pkgs.rPackages.languageserver
    pkgs.air-formatter
    pkgs.rstudio
    pkgs.nodejs_24
    pkgs.fzf
    pkgs.tmux-sessionizer
    pkgs.tmux
    pkgs.ghostty
    pkgs.unzip
    pkgs.typescript-language-server
    # pkgs_stable.quartus-prime-lite
    pkgs.vhdl-ls
    pkgs.fastfetch
    pkgs.imagemagick
    pkgs.chafa
    pkgs.nmap
    pkgs.zip
    pkgs.glsl_analyzer
    pkgs.hyprsunset
    pkgs.ddcutil
    nodePackages.vscode-json-languageserver
    vscode-langservers-extracted
    pkgs.fixjson
    pkgs.brave
    pkgs.yt-dlp
    pkgs.vue-language-server
    pkgs.typescript-language-server
    pkgs.tailwindcss-language-server
    pkgs.typescript
    pkgs.cava
    pkgs.lolcat
    pkgs.pipes
    pkgs.cmatrix
    pkgs.firejail
    pkgs.bambu-studio
    pkgs.jellyfin-media-player
    pkgs.jdk
    pkgs.gif-for-cli
    pkgs.feather
    pkgs.tty-clock
    pkgs.grimblast
    pkgs.vlc
    pkgs.libreoffice-qt6-fresh
  ];

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.iosevka
    pkgs.font-awesome
    pkgs.nerd-fonts.space-mono
    pkgs.nerd-fonts.zed-mono
    pkgs.nerd-fonts.im-writing
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.icomoon-feather
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
