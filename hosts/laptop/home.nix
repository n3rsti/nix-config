{
  config,
  ...
}:
let

  symlinkRoot = "${config.home.homeDirectory}/.config/dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ../default/home.nix
  ];

  sops.secrets.id_laptop = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };

  home.file.".config/quickshell/per-machine/Icons.qml".source =
    link "${symlinkRoot}/quickshell/per-machine/Icons.laptop.qml";
}
