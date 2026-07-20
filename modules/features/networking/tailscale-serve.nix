{
  flake.nixosModules.tailscale-serve =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      inherit (lib)
        mkIf
        mkOption
        mapAttrs'
        nameValuePair
        types
        ;
      cfg = config.services.tailscaleServe;

      enabledApps = lib.filterAttrs (_: app: app.enable) cfg.apps;
    in
    {
      options.services.tailscaleServe.apps = mkOption {
        default = { };

        type = types.attrsOf (
          types.submodule (
            { name, ... }: {
              options = {
                enable = mkOption {
                  type = types.bool;
                  default = true;
                  description = "Whether to expose this application through Tailscale Serve.";
                };

                serviceName = mkOption {
                  type = types.str;
                  default = name;
                  description = "Tailscale service name, without the svc: prefix.";
                };

                target = mkOption {
                  type = types.str;
                  example = "http://127.0.0.1:3000";
                  description = "Local URL proxied by Tailscale Serve.";
                };

                httpsPort = mkOption {
                  type = types.port;
                  default = 443;
                  description = "HTTPS port exposed through Tailscale Serve.";
                };

                after = mkOption {
                  type = types.listOf types.str;
                  default = [ ];
                  example = [ "myapp.service" ];
                  description = "Additional systemd units this service should start after.";
                };

                wants = mkOption {
                  type = types.listOf types.str;
                  default = [ ];
                  description = "Additional systemd units this service should want.";
                };
              };
            }
          )
        );

        description = "Applications exposed through Tailscale Serve.";
      };

      config = mkIf (enabledApps != { }) {
        systemd.services = mapAttrs' (
          name: app:
          nameValuePair "tailscale-serve-${name}" {
            description = "Expose ${name} through Tailscale Serve";

            after = [ "tailscaled.service" ] ++ app.after;
            wants = [ "tailscaled.service" ] ++ app.wants;
            wantedBy = [ "multi-user.target" ];

            path = [ pkgs.tailscale ];

            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
              Restart = "on-failure";
              RestartSec = "2s";
            };

            script = ''
              tailscale serve \
                --yes \
                --service=${lib.escapeShellArg "svc:${app.serviceName}"} \
                --https=${toString app.httpsPort} \
                ${lib.escapeShellArg app.target}
            '';
          }
        ) enabledApps;
      };
    };
}
