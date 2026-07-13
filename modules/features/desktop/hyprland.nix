_: {
  flake.nixosModules.hyprland =
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

      security.polkit.enable = true;
    };

  flake.homeModules.hyprland =
    {
      pkgs,
      config,
      dotfilesPath,
      ...
    }:

    let
      link = config.lib.file.mkOutOfStoreSymlink;
    in

    {
      home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };

      xdg.configFile = {
        "hypr" = {
          source = link "${dotfilesPath}/hypr";
          recursive = true;
        };
      };

      home.packages = with pkgs; [
        grim # Utility for grimblast i think
        grimblast # Screenshot utility
        hyprpicker # Color picker
        libnotify # Notification utilities
        slurp # Area picker for screen recording
        wev # Mouse / keyboard input analyzer
        wl-clipboard # wl-copy
      ];
    };
}
