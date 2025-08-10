{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Krzysztof Witucki";
    userEmail = "n3rsti@protonmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };
}
