{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.9;
      themeFile = "Catppuccin-Mocha";
    };
  };
}
