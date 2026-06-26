{ self, ... }:
{
  flake.nixosModules.workstation = _: {
    imports = [
      self.nixosModules.base
      self.nixosModules.boot
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.mobile-devices
      self.nixosModules.networking
      self.nixosModules.kdeconnect
      self.nixosModules.localsend
      self.nixosModules.tailscale-client
      self.nixosModules.zerotier
      self.nixosModules.fonts
      self.nixosModules.packages
      self.nixosModules.workstation-tools
      self.nixosModules.docker
      self.nixosModules.librepods
    ];

    nixpkgs.config.android_sdk.accept_license = true;
  };

  flake.homeModules.workstation = _: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.networking
      self.homeModules.kdeconnect
      self.homeModules.dev
      self.homeModules.gaming
      self.homeModules.application-suite
      self.homeModules.downloads
      self.homeModules.tailscale-client
    ];

    dev.kotlin.enable = false;
    dev.csharp.enable = false;
  };
}
