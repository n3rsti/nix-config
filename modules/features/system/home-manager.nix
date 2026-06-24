{ inputs, ... }:
{
  flake.nixosModules.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      overwriteBackup = true;

      sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };
}
