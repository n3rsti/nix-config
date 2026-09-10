{ inputs, mkNixosSystem, ... }:
{
  flake.nixosConfigurations.optiplex = mkNixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.disko.nixosModules.disko
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
            loader = {
              systemd-boot.enable = true;
              efi.canTouchEfiVariables = true;
            };
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

          services.openssh = {
            enable = true;
            settings = {
              PasswordAuthentication = false;
              PermitRootLogin = "prohibit-password";
            };
          };

          users.users.n3rsti = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keyFiles = [ ../../../keys/id_pc.pub ];
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
