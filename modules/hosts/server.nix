{ inputs, self, ... }:
{
  flake.nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.server-profile
      self.nixosModules.minecraft
      self.nixosModules.remote-builder
      self.nixosModules.arr
      self.nixosModules.nextcloud
      self.nixosModules.immich
      self.nixosModules.paperless
      self.nixosModules.uptime-kuma
      self.nixosModules.attic
      self.nixosModules.pi-hole
      self.nixosModules.glance
      self.nixosModules.docker
      ./server/_hardware-configuration.nix

      (
        { pkgs, ... }:
        {
          boot.kernel = {
            sysctl."net.ipv4.ip_forward" = 1;
            sysctl."net.ipv6.conf.all.forwarding" = 1;
          };

          home-manager.users.n3rsti.imports = [
            self.homeModules.n3rsti-server
            self.homeModules.opencode
            self.homeModules.javascript
          ];

          dev.javascript.enable = true;

          programs.ssh = {
            startAgent = true;
            extraConfig = ''
              AddKeysToAgent yes
            '';
          };

          users = {
            users.n3rsti = {
              isNormalUser = true;
              description = "n3rsti";
              shell = pkgs.zsh;
              extraGroups = [
                "networkmanager"
                "wheel"
                "docker"
                "media"
              ];

              openssh.authorizedKeys.keyFiles = [
                ../../keys/id_pc.pub
                ../../keys/id_laptop.pub
              ];
            };

            groups.media = { };
          };

          fileSystems."/srv/storage" = {
            device = "/dev/disk/by-uuid/0ca806d5-a704-4eda-9e16-159fb418928e";
            fsType = "ext4";
          };

          fileSystems."/srv/media" = {
            device = "/srv/storage/media";
            fsType = "none";
            options = [ "bind" ];
            depends = [ "/srv/storage" ];
          };

          systemd.tmpfiles.settings."10-storage" = {
            "/srv/storage/media".d = {
              mode = "2775";
              user = "n3rsti";
              group = "media";
            };

            "/srv/storage/immich".d = {
              mode = "0700";
              user = "immich";
              group = "immich";
            };

            "/srv/storage/paperless".d = {
              mode = "0750";
              user = "paperless";
              group = "paperless";
            };

            "/srv/storage/nextcloud".d = {
              mode = "0750";
              user = "nextcloud";
              group = "nextcloud";
            };
          };

          environment.systemPackages = with pkgs; [
            nano
            neovim
            btop
            wakeonlan
            age
            sops
            ghostty
          ];

          networking = {
            networkmanager.enable = true;
            hostName = "server";
            firewall.allowedTCPPorts = [ ];
          };

          services.xserver.xkb = {
            layout = "us";
            variant = "";
          };

          sops = {
            defaultSopsFile = ../../secrets/secrets.yaml;
            age.keyFile = "/var/lib/sops-nix/key.txt";
            age.generateKey = true;

            secrets = {
              hetzner_storagebox = { };
            };
          };

          environment.sessionVariables = {
            SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
          };

          system.stateVersion = "24.11";
        }
      )
    ];
  };
}
