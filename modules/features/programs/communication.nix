{
  flake.homeModules.communication =
    {
      pkgs,
      ...
    }:
    {
      programs.discord = {
        enable = true;
        package = pkgs.unstable.discord;
      };

      home.packages = with pkgs; [
        slack
        unstable.protonmail-desktop
        unstable.signal-desktop
      ];

      xdg.autostart = {
        enable = true;
        entries = [
          "${pkgs.signal-desktop}/share/applications/signal.desktop"
        ];
      };
    };
}
