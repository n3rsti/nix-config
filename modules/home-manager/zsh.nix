{ config, pkgs, ... }:

{
  programs.zsh = {
    #enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "zsh-autosuggestions"
      ];
      theme = "fwalch";
    };
  };
}

