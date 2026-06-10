{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.cli.core;
in
{
  options.profile.programs.cli.core.enable = lib.mkEnableOption "core command-line tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bc
      btop
      duf
      eza # better ls
      fastfetch
      fd
      fzf
      jq
      lsof
      ripgrep
      television # tv
      tmux
      tree
      unzip
      wget
      zip
    ];
  };
}
