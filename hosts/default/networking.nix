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

  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-dns"
      "--accept-routes"
      "--exit-node-allow-lan-access"
    ];
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "56374ac9a42a3c0f" ];
  };

  networking.hostName = lib.mkDefault "nixos";

  networking.networkmanager.enable = lib.mkDefault true;

  networking.firewall.allowedUDPPorts = [
    9993
  ];

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
