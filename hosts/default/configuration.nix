{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./packages.nix
    ../../modules/nixos/dev/default.nix
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/desktop-manager/sddm.nix
    ../../modules/nixos/gaming/gaming.nix
    ../../modules/nixos/boot/boot.nix
    ../../modules/nixos/boot/plymouth.nix
    ../../modules/nixos/virtualisation.nix
    ../../modules/nixos/networking/networking.nix
    ../../modules/nixos/networking/tailscale.nix
    ../../modules/nixos/networking/zerotier.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/locale.nix
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
    kotlin.enable = false;
  };

  swapDevices = lib.mkForce [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  nix = {
    settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
      trusted-users = [
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

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

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
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
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
      "libvirtd"
      "stlink"
      "i2c"
    ];
  };

  virtualisation.docker.enable = true;

  security.rtkit.enable = true;

  services = {
    udev.packages = [
      pkgs.openocd
      pkgs.stlink
    ];

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

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
        "sh.ppy.osu"
      ];
    };

  };

  programs = {
    nh.enable = true;
    dconf.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
