{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/profiles/workstation.nix
    ../../users/n3rsti.nix
    ../../modules/nixos/builder/remote-builder.nix
    ../../modules/nixos/gaming/sunshine.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/networking/openssh.nix
    ../../modules/nixos/hardware/gpu/amd.nix
    ../../modules/nixos/hardware/tablet.nix
    ../../modules/nixos/hardware/rgb.nix
    ../../modules/nixos/virtualisation/libvirt.nix
  ];

  home-manager.users.n3rsti = {
    imports = [
      ./home.nix
    ];
  };

  networking = {
    hostName = "pc";

    interfaces.enp34s0 = {
      wakeOnLan.enable = true;
    };
  };

  services = {
    input-remapper = {
      enable = true;
    };
    flatpak.packages = [
      "sh.ppy.osu"
    ];
  };

  hardware.i2c.enable = true; # For monitor brightness control

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
