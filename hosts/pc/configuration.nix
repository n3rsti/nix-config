{
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../default/configuration.nix
    ../../modules/builder/remote-builder.nix
    ../../modules/nixos/autologin.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/gaming/sunshine.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    users = {
      "n3rsti" = import ./home.nix;
    };
  };

  nix.settings = {
    cores = 4;
    max-jobs = 4;
  };

  networking = {
    hostName = "pc";

    interfaces.enp34s0 = {
      wakeOnLan.enable = true;
    };
  };

  services = {
    openssh.enable = true;

    input-remapper = {
      enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
    opentabletdriver.enable = true;
  };
}
