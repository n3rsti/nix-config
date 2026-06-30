{ self, ... }:
{
  flake.nixosModules.networking =
    { ... }:
    {
      imports = [
        self.nixosModules.networkmanager
        self.nixosModules.ssh-agent
      ];
    };

  flake.homeModules.networking = { ... }: {
    imports = [
      self.homeModules.networkmanager
    ];
  };
}
