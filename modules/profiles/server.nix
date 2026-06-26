{ self, ... }:
{
  flake.nixosModules.server = {
    imports = [
      self.nixosModules.base
      self.nixosModules.systemd-boot
      self.nixosModules.openssh
      self.nixosModules.tailscale
      self.nixosModules.docker
      self.nixosModules.pgsql-backup
    ];
  };

  flake.homeModules.server = {
    imports = [
      self.homeModules.base
    ];
  };
}
