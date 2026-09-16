{ self, ... }:
{
  flake.nixosModules.workstation-profile = { lib, ... }: {
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
      self.nixosModules.docker
      self.nixosModules.librepods
      self.nixosModules.hyprland
      self.nixosModules.noctalia
      self.nixosModules.binary-cache
      self.nixosModules.appimage
    ];

    nixpkgs.config.android_sdk.accept_license = true;

    services.displayManager.defaultSession = lib.mkDefault "hyprland-uwsm";
  };

  flake.homeModules.workstation-profile = { pkgs, ... }: {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.networking
      self.homeModules.kdeconnect
      self.homeModules.dev
      self.homeModules.java
      self.homeModules.javascript
      self.homeModules.go
      self.homeModules.gaming
      self.homeModules.apps
      self.homeModules.tailscale-client
      self.homeModules.hyprland
      self.homeModules.noctalia
      self.homeModules.walker
      self.homeModules.rdp
    ];

    home.packages = with pkgs; [
      snx-rs
    ];
  };
}
