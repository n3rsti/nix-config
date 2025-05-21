{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "fwalch";
    };
    shellAliases = {
      "nix-update" = "sudo nix-channel --update";
      "nix-switch" = "sudo nixos-rebuild switch --flake ~/nixos#\${1:-default}";
      "nix-test" = "sudo nixos-rebuild test --flake ~/nixos#\${1:-default}";
    };
  };
}
