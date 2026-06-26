{ self, ... }:
{
  flake.nixosModules.networking = _: {
    imports = [
      self.nixosModules.networkmanager
      self.nixosModules.ssh-agent
    ];
  };

  flake.homeModules.networking = {
    imports = [
      self.homeModules.networkmanager
      self.homeModules.rdp
    ];
  };
}
