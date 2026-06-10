{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unstable.neovim
    sshfs
    unstable.tree-sitter
  ];
}
