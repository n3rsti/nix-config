{ inputs, self, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.workstation
      self.nixosModules.n3rsti
      self.nixosModules.distributed-builds
      self.nixosModules.swap
      self.nixosModules.intel
      self.nixosModules.backlight
      self.nixosModules.power-management
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
      ./laptop/_hardware-configuration.nix

      (
        { pkgs, ... }:
        {
          boot.kernelParams = [ "psmouse.synaptics_intertouch=1" ];

          home-manager.users.n3rsti =
            { config, ... }:
            {
              imports = [
                self.homeModules.n3rsti
                self.homeModules.sops
              ];

              sops.secrets.id_laptop = {
                path = "${config.home.homeDirectory}/.ssh/id_ed25519";
                mode = "0600";
              };
            };

          networking.hostName = "laptop";

          environment.systemPackages = with pkgs; [
            moonlight-qt
          ];

          system.stateVersion = "24.11";
        }
      )
    ];
  };
}
