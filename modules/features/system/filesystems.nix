{
  flake.nixosModules.filesystems =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        exfatprogs
        parted
      ];
    };
}
