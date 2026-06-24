{
  flake.homeModules.productivity =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        errands # Task manager
        gnome-calendar
        gnome-clocks
        gnome-weather # Weather app
      ];
    };
}
