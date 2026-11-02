{ inputs, ... }:
{
  flake.nixosModules.comin = {
    imports = [
      inputs.comin.nixosModules.comin
    ];

    services.comin = {
      enable = true;
      remotes = [
        {
          name = "origin";
          url = "https://github.com/n3rsti/nix-config.git";
          branches.main.name = "deploy";
        }
      ];
    };
  };
}
