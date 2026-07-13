{ self, ... }:
{
  flake.nixosModules.workstation-profile = _: {
    imports = [
      self.nixosModules.base
      self.nixosModules.boot
      self.nixosModules.desktop
      self.nixosModules.gaming
      self.nixosModules.mobile-devices
      self.nixosModules.networking
      self.nixosModules.avahi
      self.nixosModules.kdeconnect
      self.nixosModules.localsend
      self.nixosModules.tailscale-client
      self.nixosModules.zerotier
      self.nixosModules.fonts
      self.nixosModules.filesystems
      self.nixosModules.diagnostics
      self.nixosModules.docker
      self.nixosModules.librepods
      self.nixosModules.hyprland
      self.nixosModules.noctalia
      self.nixosModules.dev
      self.nixosModules.binary-cache
      self.nixosModules.appimage
    ];

    nixpkgs.config.android_sdk.accept_license = true;

    services.displayManager.defaultSession = "hyprland-uwsm";
  };

  flake.homeModules.workstation-profile = { pkgs, ... }: {
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
      self.homeModules.web-apps
      self.homeModules.hyprland
      self.homeModules.noctalia
      self.homeModules.walker
      self.homeModules.rdp
    ];

    home.packages = with pkgs; [
      snx-rs
    ];

    dev.kotlin.enable = false;
    dev.csharp.enable = false;
  };
}
