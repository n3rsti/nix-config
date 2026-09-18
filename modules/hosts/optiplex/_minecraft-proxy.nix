{ pkgs, ... }:
let
  minecraftServerIp = "192.168.0.8";
in
{
  networking.firewall.allowedTCPPorts = [ 25565 ];

  systemd.sockets.minecraft-proxy = {
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenStream = "25565";
      Accept = true;
    };
  };

  systemd.services."minecraft-proxy@" = {
    description = "Minecraft TCP proxy";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.socat}/bin/socat - TCP4:${minecraftServerIp}:25565";
      StandardInput = "socket";
      StandardOutput = "socket";
      StandardError = "journal";
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
