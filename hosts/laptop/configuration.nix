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
    inputs.home-manager.nixosModules.default
  ];

  nix.settings = {
    cores = 4;
    max-jobs = 4;
  };

  boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];

  home-manager = {
    users = {
      "n3rsti" = import ./home.nix;
    };
  };

  networking = {
    hostName = "laptop";
  };

  environment.systemPackages = with pkgs; [
    moonlight-qt
    brightnessctl
  ];

  powerManagement.enable = true;

  services = {
    tlp.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    upower.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ];
    };
    cpu.intel.updateMicrocode = true;
    acpilight.enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
