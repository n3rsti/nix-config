{
  flake.homeModules.ghostty =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unstable.ghostty
      ];
    };
}
