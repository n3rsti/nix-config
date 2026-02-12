{
  config,
  pkgs,
  inputs,
  ...
}:
let
  pkgs_stable = (
    import inputs.nixpkgs_stable {
      inherit (pkgs.stdenv.hostPlatform) system;
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
    ../default/configuration.nix
    ../../modules/builder/remote-builder.nix
    inputs.home-manager.nixosModules.default
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  nix.settings.cores = 3;
  nix.settings.max-jobs = 3;

  networking.hostName = "pc";

  networking.interfaces.enp34s0 = {
    wakeOnLan.enable = true;
  };

  services.input-remapper = {
    enable = true;
    package = pkgs_stable.input-remapper;
  };

  services.sunshine = {
    enable = false;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.openssh.enable = true;

  hardware.opentabletdriver.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.osu-lazer
    # pkgs.opentabletdriver

    (pkgs.heroic.override { extraPkgs = pkgs: [ pkgs.gamescope ]; })
  ];
}
