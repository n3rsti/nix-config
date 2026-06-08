{
  pkgs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../default/configuration.nix
    ../../modules/nixos/builder/distributed-builds.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/hardware/gpu/intel.nix
    ../../modules/nixos/hardware/backlight.nix
    ../../modules/nixos/hardware/power_management.nix
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

}
