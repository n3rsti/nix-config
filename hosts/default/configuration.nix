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
    ./packages.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.trusted-users = [
    "root"
    "n3rsti"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.accept-flake-config = true;

  nix.settings.max-jobs = lib.mkDefault 8;
  nix.settings.cores = lib.mkDefault 0;

  nix.settings.auto-optimise-store = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "n3rsti" =
        { pkgs, ... }:
        {
          imports = [ ./home.nix ];
        };
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
  };

  users.users.n3rsti = {
    isNormalUser = true;
    description = "n3rsti";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "ydotool"
      "docker"
      "dialout"
      "input"
      "gamemode"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    plymouth = {
      enable = true;
      theme = "red_loader";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "red_loader" ];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };

  networking.hostName = lib.mkDefault "nixos";

  networking.networkmanager.enable = lib.mkDefault true;

  networking.firewall.allowedUDPPorts = [
    9993
  ];

  networking.firewall.allowedTCPPorts = [
    8080
  ];

  time.timeZone = lib.mkDefault "Europe/Warsaw";

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
    LC_TIME = "en_US.UTF-8";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  users.extraGroups.vboxusers.members = [ "n3rsti" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.pipewire.wireplumber.enable = true;

  services.pulseaudio.enable = false;

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "56374ac9a42a3c0f" ];
  };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-dns"
      "--accept-routes"
      "--exit-node-allow-lan-access"
    ];
  };

  services.playerctld.enable = true;

  services.udisks2.enable = true;

  services.gvfs.enable = true; # for nautilus

  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-online-accounts.enable = true;

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

  programs.dconf.enable = true;

  virtualisation.docker.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  programs.zsh.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.nix-ld.enable = true;
  programs.direnv.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = inputs.self.outPath;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    font-awesome
    nerd-fonts.space-mono
    nerd-fonts.zed-mono
    nerd-fonts.im-writing
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.adwaita-mono
    icomoon-feather
    adwaita-fonts
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    LM_LICENSE_FILE = "\${HOME}/Downloads/license.dat";
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
  services.gnome.gcr-ssh-agent.enable = false;

  programs.ydotool = {
    enable = true;
    group = "users";
  };

  hardware.bluetooth = {
    enable = lib.mkDefault true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
