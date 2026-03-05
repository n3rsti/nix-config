{
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.hypridle.enable = true;

  systemd.services.display-manager.path = [ pkgs.uwsm ];
}
