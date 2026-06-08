{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../default/configuration.nix
    ../../modules/nixos/builder/remote-builder.nix
    ../../modules/nixos/autologin.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/gaming/sunshine.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/openssh.nix
    ../../modules/nixos/hardware/gpu/amd.nix
    ../../modules/nixos/hardware/tablet.nix
    ../../modules/nixos/hardware/rgb.nix
    ../../modules/nixos/virtualisation.nix
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
  };

  hardware.i2c.enable = true; # For monitor brightness control
}
