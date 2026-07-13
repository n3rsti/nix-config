{ self, ... }:
{
  flake.nixosModules.vm-profile = _: {
    imports = [
      self.nixosModules.base
      self.nixosModules.boot
      self.nixosModules.i3
      self.nixosModules.networking
      self.nixosModules.fonts
      self.nixosModules.filesystems
      self.nixosModules.diagnostics
      self.nixosModules.docker

      self.nixosModules.gnome-services
      self.nixosModules.gdm
      self.nixosModules.dev
    ];

    nixpkgs.config.android_sdk.accept_license = true;
    services.displayManager.defaultSession = "none+i3";

    dev.microcontrollers.enable = false;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };

  flake.homeModules.vm-profile = _: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.networking
      self.homeModules.dev
      self.homeModules.browsers
    ];

    dev.kotlin.enable = false;
    dev.csharp.enable = false;
    dev.microcontrollers.enable = false;
  };
}
