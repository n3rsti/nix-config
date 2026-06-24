{ inputs, ... }:
{
  flake.nixosModules.nur = {
    imports = [
      inputs.nur.modules.nixos.default
    ];
  };
}
