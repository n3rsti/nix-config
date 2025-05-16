{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = 0.9;
      confirm_os_window_close = 0;
    };
  };
}
