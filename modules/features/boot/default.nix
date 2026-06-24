{ self, ... }:
{
  flake.nixosModules.boot = {
    imports = [
      self.nixosModules.systemd-boot
      self.nixosModules.plymouth
    ];
  };
}
