_: {
  flake.nixosModules.netboot =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    let
      cfg = config.services.netboot;

      image = lib.nixosSystem {
        system = pkgs.stdenv.hostPlatform.system;
        modules = [
          "${modulesPath}/installer/netboot/netboot.nix"
          (_: {
            networking.useDHCP = true;

            services.openssh = {
              enable = true;
              settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "prohibit-password";
              };
            };

            networking.firewall.allowedTCPPorts = [ 22 ];

            users.users.root.openssh.authorizedKeys.keyFiles = cfg.authorizedKeyFiles;

            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            system.stateVersion = "26.05";
          })
        ];
      };
    in
    {
      options.services.netboot = {
        enable = lib.mkEnableOption "NixOS network boot service";

        authorizedKeyFiles = lib.mkOption {
          type = lib.types.listOf lib.types.path;
          default = [ ];
          description = "SSH public-key files authorized for root in netboot image.";
        };

        listen = lib.mkOption {
          type = lib.types.str;
          default = "0.0.0.0";
          description = "IPv4 address Pixiecore listens on.";
        };

        port = lib.mkOption {
          type = lib.types.port;
          default = 80;
          description = "HTTP port Pixiecore uses to serve boot files.";
        };
      };

      config = lib.mkIf cfg.enable {
        system.build.netbootRamdisk = image.config.system.build.netbootRamdisk;

        services.pixiecore = {
          enable = true;
          dhcpNoBind = true;
          openFirewall = true;
          inherit (cfg) listen;
          inherit (cfg) port;
          statusPort = cfg.port;
          kernel = "${image.config.system.build.kernel}/${image.config.system.boot.loader.kernelFile}";
          initrd = "${image.config.system.build.netbootRamdisk}/initrd";
          cmdLine = "init=${image.config.system.build.toplevel}/init";
        };
      };
    };
}
