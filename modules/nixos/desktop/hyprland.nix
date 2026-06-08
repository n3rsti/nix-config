{
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = pkgs.unstable.hyprland;
  };

  services.displayManager.defaultSession = "hyprland-uwsm";

  # programs.uwsm.waylandCompositors = {
  #   hyprland-uwsm = {
  #     prettyName = "Hyprland (start-hyprland)";
  #     comment = "Hyprland compositor managed by UWSM";
  #     binPath = "/run/current-system/sw/bin/start-hyprland";
  #   };
  # };

  security.polkit.enable = true;
}
