{
  lib,
  ...
}:
{
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };
  services.gnome.gcr-ssh-agent.enable = false;

  networking.hostName = lib.mkDefault "nixos";

  networking.networkmanager.enable = lib.mkDefault true;

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
