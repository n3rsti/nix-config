{ lib, ... }:
{
  nix = {
    settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];

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
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
