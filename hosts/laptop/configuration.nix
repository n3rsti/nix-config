{
  pkgs,
  inputs,
  config,
  ...
}:
let
  pkgs_stable = (
    import inputs.nixpkgs_25_05 {
      inherit (pkgs) system;
      config = config.nixpkgs.config;
    }
  );
in
{

  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/main-user.nix
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

  nix.settings.cores = 3;

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
