{
  flake.nixosModules.swap =
    {
      lib,
      ...
    }:
    {
      swapDevices = lib.mkForce [
        {
          device = "/var/lib/swapfile";
          size = 32 * 1024;
        }
      ];
    };
}
