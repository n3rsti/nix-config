{ lib, ... }:
{
  imports = [
    ../dev/git.nix
    ../dev/terminal/zsh.nix
    ../programs/cli/core.nix
  ];

  profile.programs.cli.core.enable = lib.mkDefault true;

  programs.home-manager.enable = true;
}
