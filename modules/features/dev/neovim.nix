{
  flake.homeModules.neovim =
    { pkgs, config, ... }:
    let
      symlinkRoot = "${config.home.homeDirectory}/.config/dotfiles";
      link = config.lib.file.mkOutOfStoreSymlink;
    in
    {
      home.packages = with pkgs; [
        unstable.neovim
        sshfs
        unstable.tree-sitter
        ripgrep
        gcc
      ];

      xdg.configFile = {
        "nvim" = {
          source = link "${symlinkRoot}/nvim";
          recursive = true;
        };
      };
    };
}
