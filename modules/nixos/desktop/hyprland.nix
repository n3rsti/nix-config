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

  # programs.uwsm.waylandCompositors = {
  #   hyprland-uwsm = {
  #     prettyName = "Hyprland (start-hyprland)";
  #     comment = "Hyprland compositor managed by UWSM";
  #     binPath = "/run/current-system/sw/bin/start-hyprland";
  #   };
  # };

  security.polkit.enable = true;
}
