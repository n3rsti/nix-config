{ inputs, dotfilesPath, ... }:
{
  _module.args.mkNixosSystem =
    {
      system,
      modules,
      specialArgs ? { },
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system modules;

      specialArgs = {
        inherit dotfilesPath;
      }
      // specialArgs;
    };
}
