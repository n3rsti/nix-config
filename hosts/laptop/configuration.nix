{
  pkgs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/profiles/workstation.nix
    ../../users/n3rsti.nix
    ../../modules/nixos/builder/distributed-builds.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/hardware/gpu/intel.nix
    ../../modules/nixos/hardware/laptop/backlight.nix
    ../../modules/nixos/hardware/laptop/power-management.nix
  ];

  boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];

  home-manager.users.n3rsti = {
    imports = [
      ./home.nix
    ];
  };

  networking.hostName = "laptop";

  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
