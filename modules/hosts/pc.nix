{ inputs, self, ... }:
{
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.workstation-profile
      self.nixosModules.n3rsti
      self.nixosModules.maja
      self.nixosModules.remote-builder
      self.nixosModules.sunshine
      self.nixosModules.swap
      self.nixosModules.openssh
      self.nixosModules.amd
      self.nixosModules.tablet
      self.nixosModules.rgb
      self.nixosModules.libvirt
      self.nixosModules.gnome
      ./pc/_hardware-configuration.nix

      (_: {
        home-manager.users.n3rsti =
          { config, ... }:
          {
            imports = [
              self.homeModules.n3rsti
              self.homeModules.sops
            ];

            sops.secrets.id_pc = {
              path = "${config.home.homeDirectory}/.ssh/id_ed25519";
              mode = "0600";
            };

            programs.firefox.profiles.default.settings."widget.wayland.fractional-scale.enabled" = false;
          };

        home-manager.users.Maja = {
          imports = [
            self.homeModules.maja
          ];
        };

        networking = {
          hostName = "pc";

          interfaces.enp34s0 = {
            wakeOnLan.enable = true;
          };
        };

        services = {
          input-remapper.enable = true;

          flatpak.packages = [
            "sh.ppy.osu"
          ];
        };

        services.flatpak.overrides = {
          files = [ ./pc/_org.freecad.FreeCAD ];
        };

        hardware.i2c.enable = true;

        users.users.n3rsti.extraGroups = [ "lutrisgames" ];
        users.users.Maja.extraGroups = [ "lutrisgames" ];

        system.stateVersion = "24.11";
      })
    ];
  };
}
