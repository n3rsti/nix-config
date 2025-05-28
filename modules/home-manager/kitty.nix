{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = 0.9;
      confirm_os_window_close = 0;
    };
    extraConfig = ''
        map ctrl+o launch --type=overlay sh -c "~/repo/dotfiles/scripts/tmux-sessionizer.sh"
      '';
  };
}
