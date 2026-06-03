{
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../default/configuration.nix
    ../../modules/builder/distributed-builds.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/swap.nix
    ../../modules/nixos/hardware/gpu/intel.nix
    ../../modules/nixos/hardware/backlight.nix
    ../../modules/nixos/hardware/power_management.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];

  home-manager = {
    users = {
      "n3rsti" = import ./home.nix;
    };
  };

  networking.hostName = "laptop";

  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

}
