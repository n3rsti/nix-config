{
  flake.homeModules.neovim =
    {
      pkgs,
      config,
      dotfilesPath,
      ...
    }:
    let
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
          source = link "${dotfilesPath}/nvim";
          recursive = true;
        };
      };
    };
}
