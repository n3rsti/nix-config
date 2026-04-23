# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./packages.nix
    ../../modules/dev/default.nix
    ./networking.nix
    ./desktop.nix
    inputs.home-manager.nixosModules.default
  ];

  dev = {
    java.enable = true;
    c.enable = true;
    python.enable = true;
    rust.enable = true;
    go.enable = true;
    nix.enable = true;
    lua.enable = true;
    typst.enable = true;
    javascript.enable = true;
    kotlin.enable = true;
  };

  nix.settings = {
    trusted-users = [
      "root"
      "n3rsti"
    ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
    accept-flake-config = true;

    max-jobs = lib.mkDefault 4;
    cores = lib.mkDefault 4;
    auto-optimise-store = true;
    download-buffer-size = 1024 * 1024 * 1024; # 1 GiB
  };

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

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
      "kvm"
    ];
  };

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
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

  };

  virtualisation = {
    docker.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pipewire.wireplumber.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    ipp-usb.enable = true; # printers autodiscovery

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    playerctld.enable = true;

    udisks2.enable = true;
    gvfs.enable = true; # for nautilus

    gnome = {
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };

    flatpak = {
      enable = true;
      packages = [
        "org.vinegarhq.Sober"
        "com.bambulab.BambuStudio"
        "org.freecad.FreeCAD"
      ];
    };

  };

  programs = {
    nh.enable = true;
    dconf.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    gamemode.enable = true;

    zsh.enable = true;

    appimage.enable = true;
    appimage.binfmt = true;

    nix-ld.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    ydotool = {
      enable = true;
      group = "users";
    };
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
  services.blueman.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
