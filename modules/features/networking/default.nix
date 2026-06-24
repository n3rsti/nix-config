{ self, ... }:
{
  flake.nixosModules.networking = _: {
    imports = [
      self.nixosModules.networkmanager
      self.nixosModules.openssh
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
