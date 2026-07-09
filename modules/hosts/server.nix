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
          ];

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

          environment.systemPackages = with pkgs; [
            nano
            neovim
            git
            ghostty
            jdk25
            btop
            tmux
            go
            docker
            wakeonlan
            nmap
            eza
            zip
            unzip
            tree
            nixfmt
            age
            sops
            ripgrep
            devenv
            jq
          ];

          networking = {
            networkmanager.enable = true;
            hostName = "nixos";
            firewall.allowedTCPPorts = [ ];
          };

          services.networkd-dispatcher = {
            enable = true;
            rules."50-tailscale-optimizations" = {
              onState = [ "routable" ];
              script = ''
                ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
              '';
            };
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
