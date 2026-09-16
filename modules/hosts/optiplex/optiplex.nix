{
  inputs,
  self,
  mkNixosSystem,
  ...
}:
{
  flake.nixosConfigurations.optiplex = mkNixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.disko.nixosModules.disko
      self.nixosModules.pi-hole
      self.nixosModules.glance
      self.nixosModules.flaresolverr
      self.nixosModules.prowlarr
      self.nixosModules.server-profile
      (
        { pkgs, ... }:
        {
          boot = {
            initrd.availableKernelModules = [
              "ahci"
              "ehci_pci"
              "sd_mod"
              "usbhid"
              "usb_storage"
              "xhci_pci"
            ];
            kernelModules = [ "kvm-intel" ];
          };

          home-manager.users.n3rsti = {
            imports = [
              self.homeModules.base
            ];

            home.stateVersion = "26.05";
          };

          disko.devices.disk.main = {
            device = "/dev/sda";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  type = "EF00";
                  size = "1G";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };

                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };

          networking = {
            hostName = "optiplex";
            networkmanager.enable = true;
            firewall.allowedTCPPorts = [ 22 ];
          };

          programs.ssh = {
            startAgent = true;
            extraConfig = ''
              AddKeysToAgent yes
            '';
          };

          sops = {
            defaultSopsFile = ../../../secrets/secrets.yaml;
            age.keyFile = "/var/lib/sops-nix/key.txt";
            age.generateKey = true;
          };

          users.users.n3rsti = {
            shell = pkgs.zsh;
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keyFiles = [
              ../../../keys/id_pc.pub
              ../../../keys/id_laptop.pub
            ];
          };

          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          environment.systemPackages = [ pkgs.git ];
          system.stateVersion = "26.05";
        }
      )
    ];
  };
}
