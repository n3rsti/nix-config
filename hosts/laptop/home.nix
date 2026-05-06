{
  config,
  ...
}:

{
  imports = [
    ../default/home.nix
  ];

  sops.secrets.id_laptop = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };
}
