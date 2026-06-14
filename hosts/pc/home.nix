{ config, ... }:
{
  imports = [
    ../../modules/home-manager/secrets/sops.nix
  ];

  sops.secrets.id_pc = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };

  programs.firefox.profiles.default.settings."widget.wayland.fractional-scale.enabled" = false;
}
