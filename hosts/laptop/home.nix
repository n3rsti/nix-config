{
  config,
  ...
}:
{
  imports = [
    ../default/home.nix
    ../../modules/home-manager/sops.nix
    ../../modules/home-manager/performance.nix
  ];

  sops.secrets.id_laptop = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };
}
