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
    # Include the results of the hardware scan.
    # This expects hardware-configuration.nix to be present in this directory
    # Generate it using: sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/main-user.nix
    ../default/configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    users = {
      "n3rsti" = import ./home.nix;
    };
  };

  networking.hostName = "laptop";

  networking = {
    networkmanager.enable = true;
  };

  services.power-profiles-daemon.enable = false;
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = false;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  hardware.acpilight.enable = true;

  environment.systemPackages = with pkgs; [
    pkgs.moonlight-qt
    pkgs.brightnessctl
    pkgs.acpilight
    pkgs.gnome-bluetooth
  ];

  powerManagement.enable = true;
  services.tlp.enable = true; # Power management
  services.thermald.enable = true;

  hardware.graphics = {
    package = pkgs_stable.mesa;
    enable = true;
    extraPackages = pkgs.lib.mkForce (
      with pkgs_stable;
      [
        intel-media-driver
        intel-compute-runtime
      ]
    );
  };

  hardware.cpu.intel.updateMicrocode = true;
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
