{ pkgs, ... }:
{
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [
    {
      hostName = "server";
      sshUser = "remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [
        "nixos-test"
        "big-parallel"
        "kvm"
      ];
    }
    {
      hostName = "pc";
      sshUser = "remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = [
        "nixos-test"
        "big-parallel"
        "kvm"
      ];
    }
  ];
}
