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
    tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;
      };
    };
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
