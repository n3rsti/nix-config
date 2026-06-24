{
  flake.homeModules.communication =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        slack
        unstable.discord
        unstable.protonmail-desktop
        unstable.signal-desktop
      ];
    };
}
