{
  flake.homeModules.hyprland-tools =
    { pkgs, ... }:
    {
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
