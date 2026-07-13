{ inputs, ... }:
{
  flake.nixosModules.home-manager = { dotfilesPath, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      overwriteBackup = true;

      extraSpecialArgs = {
        inherit dotfilesPath;
      };
    };
  };
}
