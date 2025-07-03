{ config, pkgs, ... }:

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

    # Use shellAliases for simple no-argument aliases only
    shellAliases = {
      nix-update = "sudo nix flake update --flake ~/nixos";
      nix-switch = "'nix-switch_func'";
      nix-test = "'nix-test_func'";
      zed = "zeditor";
      vim = "nvim";
    };

    # Use initExtra for functions that need arguments
    initContent = ''
      nix-switch_func() {
        sudo nixos-rebuild switch --flake ~/nixos#"$1"
      }

      nix-test_func() {
        sudo nixos-rebuild test --flake ~/nixos#"$1"
      }
      bindkey -s ^F "/home/n3rsti/repo/dotfiles/scripts/tmux-sessionizer.sh\n"

      eval $(ssh-agent) > /dev/null
      find ~/.ssh -type f ! -name '*.pub' -exec ssh-add {} \; > /dev/null 2>&1
    '';
  };
}
