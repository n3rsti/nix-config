{ inputs, self, ... }:
{
  flake.nixosConfigurations.vm-host = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.vm
      self.nixosModules.n3rsti
      self.nixosModules.amd
      ./vm/_hardware-configuration.nix

      (_: {
        home-manager.users.n3rsti =
          { config, ... }:
          {
            imports = [
              self.homeModules.n3rsti
            ];
          };

        networking = {
          hostName = "pc";
        };

        system.stateVersion = "24.11";
      })
    ];
  };
}
