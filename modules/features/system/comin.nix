{ inputs, self, ... }:
{
  flake.nixosModules.comin = { lib, ... }: {
    imports = [
      inputs.comin.nixosModules.comin
    ];

    services.comin = {
      enable = true;
      remotes = lib.mkDefault [
        {
          name = "origin";
          url = "https://github.com/n3rsti/nix-config.git";
          branches.main.name = "deploy";
        }
      ];
    };
  };

  flake.nixosModules.comin-desktop = { lib, ... }: {
    imports = [
      self.nixosModules.comin
    ];

    services.comin.desktop.enable = true;
    services.comin.deployConfirmer.mode = lib.mkDefault "manual";
  };
}
