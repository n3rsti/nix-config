{
  flake.nixosModules.nix =
    { lib, ... }:
    {
      nix = {
        settings = {
          trusted-users = [
            "n3rsti"
          ];

          experimental-features = [
            "nix-command"
            "flakes"
          ];
          accept-flake-config = true;

          max-jobs = lib.mkDefault 4;
          cores = lib.mkDefault 4;
          auto-optimise-store = true;
          download-buffer-size = 1024 * 1024 * 1024; # 1 GiB

          substituters = [
            "http://server.tail3ce7af.ts.net:8083/nixos"
          ];
          trusted-public-keys = [
            "nixos:lVIomUEQXDQPIh/gHzcss6+IgEZ8SMIXlsdlNOFV3jc="
          ];
        };

        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 7d";
        };
      };

      nixpkgs.config.allowUnfree = true;
    };
}
