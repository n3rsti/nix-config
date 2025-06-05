{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_moon";
    settings = {
      background_opacity = 0.9;
      confirm_os_window_close = 0;
      font_family = "Adwaita Mono";
    };
    # extraConfig = ''
    #     map ctrl+o launch --type=overlay sh -c "~/repo/dotfiles/scripts/tmux-sessionizer.sh"
    #   '';
  };
}
