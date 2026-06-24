{ inputs, ... }:
{
  flake.nixosModules.unstable = {
    nixpkgs.overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs_unstable {
          system = final.stdenv.hostPlatform.system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-39.8.10"
            ];
          };
        };
      })
    ];
  };
}
