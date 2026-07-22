{
  flake.nixosModules.pi-hole =
    { config, ... }:
    let
      port = 8084;
    in
    {
      services = {
        pihole-ftl = {
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

        pihole-web = {
          enable = true;
          ports = [ port ];
        };
      };

      networking.firewall.interfaces.tailscale0 = {
        allowedTCPPorts = [ port ];
      };

      systemd.services.pihole-ftl.environment = {
        FTLCONF_webserver_api_pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$mc/Cb2em9FRAj/1tV2UtVg==$MyDlxfPufq6xFnTfeJSPIq+JJvI6ghI6tSAy2oz0DfQ=";
      };

      services.tailscaleServe.apps.pihole.target = "http://localhost:${toString port}";

      sops = {
        secrets.pihole_app_password = {
          restartUnits = [ "glance.service" ];
        };

        templates."glance.env" = {
          mode = "0400";

          content = ''
            PIHOLE_APP_PASSWORD=${config.sops.placeholder.pihole_app_password}
          '';
        };
      };

    };
}
