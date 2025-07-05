{ config, pkgs, inputs, ... }: {
  imports = [ # Include the results of the hardware scan.
    # This expects hardware-configuration.nix to be present in this directory
    # Generate it using: sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos/main-user.nix
    ../default/configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # PC-specific settings
  networking.hostName = "pc"; # Override default hostname
  services.xserver.videoDrivers = [ "nvidia" ];

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  hardware = {
    graphics.enable = true;

    nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
