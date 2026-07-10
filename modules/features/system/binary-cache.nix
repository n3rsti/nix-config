{
  flake.nixosModules.binary-cache = {
    nix.settings = {
      substituters = [
        "http://server.tail3ce7af.ts.net:8083/nixos"
      ];
      trusted-public-keys = [
        "nixos:lVIomUEQXDQPIh/gHzcss6+IgEZ8SMIXlsdlNOFV3jc="
      ];
    };
  };
}
