{ inputs, ... }:
{
  flake.nixosModules.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    home-manager.sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
