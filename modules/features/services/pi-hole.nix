{
  flake.nixosModules.pi-hole = {
    services.pihole-ftl = {
      enable = true;
      openFirewallDNS = true;

      settings.dns = {
        upstreams = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        listeningMode = "ALL";
      };

      lists = [
        # Lists can be added via URL
        {
          url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
          type = "block";
          enabled = true;
          description = "hagezi blocklist";
        }
      ];
    };

    services.pihole-web = {
      enable = true;
      ports = [ 8084 ];
    };

    networking.firewall.interfaces.tailscale0 = {
      allowedTCPPorts = [ 8084 ];
    };

    services.tailscaleServe.apps.pihole.target = "http://localhost:8084";
  };
}
