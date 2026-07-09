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
            "https://attic.tail3ce7af.ts.net/nixos"
          ];
          trusted-public-keys = [
            "nixos:59kSVSWnT2e294OYH70+jegOzMq8zhx8DWuWal43ajE="
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
