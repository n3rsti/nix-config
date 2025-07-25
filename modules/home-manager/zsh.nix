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
         export PATH="$PATH:$HOME/.npm-global/bin"
         nix-switch_func() {
           sudo nixos-rebuild switch --flake ~/nixos#"$1"
         }

         nix-test_func() {
           sudo nixos-rebuild test --flake ~/nixos#"$1"
         }
         bindkey -s ^F "/home/n3rsti/repo/dotfiles/scripts/tmux-sessionizer.sh\n"

         eval $(ssh-agent) > /dev/null
         find ~/.ssh -type f ! -name '*.pub' -exec ssh-add {} \; > /dev/null 2>&1


        # create environment variable from jdtls and lombok
      autoload -Uz add-zsh-hook

      add-zsh-hook precmd update_jdtls_env

      update_jdtls_env() {
        # Only run if cache doesn't exist (or make your own condition)
        [[ -f ~/.cache/jdtls_env ]] && return

        {
          path="$(nix eval --raw nixpkgs#lombok 2>/dev/null)/share/java/lombok.jar"
          echo "export JDTLS_JVM_ARGS='-javaagent:$path -Xbootclasspath/a:$path'" > ~/.cache/jdtls_env
        } &!
      }

      [[ -f ~/.cache/jdtls_env ]] && source ~/.cache/jdtls_env
    '';
  };
}
