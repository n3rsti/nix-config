{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Krzysztof Witucki";
        email = "n3rsti@protonmail.com";
      };
      core.editor = "nvim";
    };
  };
}
