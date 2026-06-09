{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./desktop/hyprland.nix
    ./desktop-manager/sddm.nix
    ./gaming/gaming.nix
    ./boot/boot.nix
    ./boot/plymouth.nix
    ./networking/networking.nix
    ./networking/tailscale/client.nix
    ./networking/zerotier.nix
    ./audio.nix
    ./printing.nix
    ./locale.nix
    ./fonts.nix
    ./localsend.nix
    ./kdeconnect.nix
    ../../users/n3rsti.nix
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  environment.systemPackages = with pkgs; [
    dmidecode
    acpi
    parted
    exfatprogs
    usbutils
    libimobiledevice
    snx-rs
    vulkan-tools
    efibootmgr
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
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };

  virtualisation.docker.enable = true;

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
}
