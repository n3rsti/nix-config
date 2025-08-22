# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../../modules/nixos/main-user.nix
    ./packages.nix
    inputs.home-manager.nixosModules.default
  ];

  main-user.enable = true;
  main-user.userName = "n3rsti";

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "n3rsti" =
        { pkgs, ... }:
        {
          imports = [ ./home.nix ];
          home.pointerCursor = {
            gtk.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 16;
          };

          # xdg.mimeApps = {
          #   enable = true;
          #   defaultApplications = {
          #     # Image MIME types for Eye of GNOME
          #     "image/bmp" = "org.gnome.eog.desktop";
          #     "image/gif" = "org.gnome.eog.desktop";
          #     "image/jpeg" = "org.gnome.eog.desktop";
          #     "image/jpg" = "org.gnome.eog.desktop";
          #     "image/png" = "org.gnome.eog.desktop";
          #     "image/tiff" = "org.gnome.eog.desktop";
          #     "image/webp" = "org.gnome.eog.desktop";
          #
          #     # Web-related
          #     "text/html" = "zen-beta.desktop";
          #     "x-scheme-handler/http" = "zen-beta.desktop";
          #     "x-scheme-handler/https" = "zen-beta.desktop";
          #     "x-scheme-handler/chrome" = "zen-beta.desktop";
          #
          #     # HTML extensions
          #     "application/x-extension-htm" = "zen-beta.desktop";
          #     "application/x-extension-html" = "zen-beta.desktop";
          #     "application/x-extension-shtml" = "zen-beta.desktop";
          #     "application/xhtml+xml" = "zen-beta.desktop";
          #     "application/x-extension-xhtml" = "zen-beta.desktop";
          #     "application/x-extension-xht" = "zen-beta.desktop";
          #   };
          # };

        };
    };
    # This allows specific host configurations to override home-manager settings
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.n3rsti = {
    isNormalUser = true;
    description = "n3rsti";
    extraGroups = [
      "networkmanager"
      "wheel"
      "networkmanager"
      "ydotool"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

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
  networking.interfaces.enp34s0 = {
    wakeOnLan.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 9993 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.gdm.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,pl";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  services.pipewire.wireplumber.enable = true;

  # services.pipewire.wireplumber.extraConfig = {
  #   "bluez-monitor.conf" = {
  #     "properties" = {
  #       "bluez5.enable-msbc" = true;
  #       "bluez5.enable-hw-volume" = true;
  #       "bluez5.codecs" = [
  #         "ldac"
  #         "aac"
  #         "sbc"
  #         "sbc_xq"
  #       ];
  #       "bluez5.roles" = [
  #         "a2dp_sink"
  #         "hfp_hf"
  #       ];
  #     };
  #   };
  # };
  #
  services.pulseaudio.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.resolved.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "56374ac9a42a3c0f" ];
  };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  services.tailscale.enable = true;

  services.playerctld.enable = true;

  services.udisks2.enable = true;

  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  programs.zsh.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.nix-ld.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.max-jobs = lib.mkDefault 8;
  nix.settings.cores = 0;

  nix.settings.auto-optimise-store = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.iosevka
    pkgs.font-awesome
    pkgs.nerd-fonts.space-mono
    pkgs.nerd-fonts.zed-mono
    pkgs.nerd-fonts.im-writing
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.adwaita-mono
    pkgs.icomoon-feather
    pkgs.adwaita-fonts
  ];

  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    LM_LICENSE_FILE = "\${HOME}/Downloads/license.dat";
  };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
