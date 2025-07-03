{ config, pkgs, inputs, ... }: {
  imports = [ # Include the results of the hardware scan.
    # This expects hardware-configuration.nix to be present in this directory
    # Generate it using: sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/main-user.nix
    ../default/configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Override home-manager configuration for this specific host
  home-manager = { users = { "n3rsti" = import ./home.nix; }; };

  # Laptop-specific settings
  networking.hostName = "laptop"; # Override default hostname

  services.power-profiles-daemon.enable = false;
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = false; # Disable touchpad while typing
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;


  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.moonlight-qt
];
  # services.blueman.enable = true;

  # programs.light.enable = true;

  # Example laptop-specific configurations
  powerManagement.enable = true;
  services.tlp.enable = true; # Power management
  services.thermald.enable = true;
  # services.auto-cpufreq.enable = true;

  # Example display/backlight configuration
  # services.actkbd = {
  #   enable = true;
  #   bindings = [
  #     { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -U 10"; }
  #     { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -A 10"; }
  #   ];
  # };
}
