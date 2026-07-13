{
  flake.homeModules.tmux = {
    programs.tmux = {
      enable = true;

      baseIndex = 1;
      mouse = true;
      prefix = "C-a";
      terminal = "screen-256color";

      extraConfig = ''
        setw -g pane-base-index 1
        set-option -g focus-events on

        bind-key -n C-f run-shell "tmux neww ~/.config/dotfiles/scripts/tmux-sessionizer.sh"

        set -g allow-passthrough on
        set -g visual-activity off

        set -g status-style 'bg=#16161e fg=#a9b1d6'
        set -g window-status-current-format " #[bold]#I:#W#[default]* "
        set -g window-status-format " #I:#W- "

        set -ga terminal-overrides ",screen-256color*:Tc"
      '';
    };
  };
}
