{
  pkgs,
  config,
  inputs,
  ...
}:

let
  pkgs_unstable = (
    import inputs.nixpkgs_unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = pkgs_unstable.hyprland;
  };
  programs.uwsm.waylandCompositors = {
    hyprland-uwsm = {
      prettyName = "Hyprland (UWSM)";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/start-hyprland";
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.hypridle.enable = true;

  systemd.services.display-manager.path = [ pkgs.uwsm ];

  security.polkit.enable = true;
}
