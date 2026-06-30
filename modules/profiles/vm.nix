{ self, ... }:
{
  flake.nixosModules.vm-profile = _: {
    imports = [
      self.nixosModules.base
      self.nixosModules.boot
      self.nixosModules.desktop
      self.nixosModules.i3
      self.nixosModules.networking
      self.nixosModules.fonts
      self.nixosModules.filesystems
      self.nixosModules.diagnostics
      self.nixosModules.workstation-tools
      self.nixosModules.docker
    ];

    nixpkgs.config.android_sdk.accept_license = true;
    services.displayManager.defaultSession = "none+i3";
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
  };
}
