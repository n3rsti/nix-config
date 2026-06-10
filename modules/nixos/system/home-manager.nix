{ inputs, ... }:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    overwriteBackup = true;
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
