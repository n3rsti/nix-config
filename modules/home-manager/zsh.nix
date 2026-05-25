{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "fwalch";
    };

    shellAliases = {
      nix-update = "sudo nix flake update --flake /etc/nixos";
      zed = "zeditor";
      vim = "nvim";
      ls = "eza -h --group-directories-first --icons=auto";
      lt = "eza --tree --level=2 --icons --git";
    };

    initContent = ''
      export PATH="$PATH:$HOME/.npm-global/bin"

      nix-switch() {
        sudo nixos-rebuild switch --flake /etc/nixos#"$1"
      }

      nix-test() {
        sudo nixos-rebuild test --flake /etc/nixos#"$1"
      }

      open() {
        xdg-open "$@" >/dev/null 2>&1 &
      }

      nix-eval() {
        if (( $# != 1 )); then
          print -u2 "usage: nix-eval <attr-path>"
          print -u2 "example: nix-eval config.services.openssh.enable"
          return 2
        fi

        nix eval "/etc/nixos#nixosConfigurations.$(hostname).$1"
      }

      bindkey -s ^F "~/.config/dotfiles/scripts/tmux-sessionizer.sh\n"

      if ! ssh-add -l >/dev/null 2>&1; then
          for key in "$HOME"/.ssh/*(.N); do
            [[ "$key" != *.pub ]] || continue

            ssh-keygen -y -f "$key" -P "" >/dev/null 2>&1 &&
              ssh-add -q -- "$key" >/dev/null 2>&1
          done
      fi
    '';
  };
}
