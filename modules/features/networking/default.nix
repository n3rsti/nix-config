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

  flake.homeModules.networking = { pkgs, ... }: {
    imports = [
      self.homeModules.networkmanager
      self.homeModules.rdp
    ];

    home.packages = with pkgs; [
      snx-rs
    ];
  };
}
