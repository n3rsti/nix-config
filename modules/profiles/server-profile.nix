{ self, ... }:
{
  flake.nixosModules.server-profile = {
    imports = [
      self.nixosModules.base
      self.nixosModules.systemd-boot
      self.nixosModules.openssh
      self.nixosModules.tailscale
      self.nixosModules.docker
      self.nixosModules.pgsql-backup
      self.nixosModules.binary-cache
    ];
  };

  flake.homeModules.server-profile = {
    imports = [
      self.homeModules.base
    ];
  };
}
