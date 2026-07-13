{
  flake.homeModules.downloads =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        qbittorrent
      ];
    };
}
