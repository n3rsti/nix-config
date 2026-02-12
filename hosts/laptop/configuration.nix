{
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
    ../default/configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];

  home-manager = {
    users = {
      "n3rsti" = import ./home.nix;
    };
  };

  networking = {
    hostName = "laptop";
    firewall.checkReversePath = "loose";
  };

  services.power-profiles-daemon.enable = false;

  hardware.acpilight.enable = true;

  environment.systemPackages = with pkgs; [
    pkgs.moonlight-qt
    pkgs.brightnessctl
    pkgs.gnome-bluetooth
  ];

  powerManagement.enable = true;
  services.tlp.enable = true;
  services.thermald.enable = true;

  nix.settings.cores = 0;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
