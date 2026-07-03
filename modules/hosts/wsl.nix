{ inputs, self, ... }:
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.base

      (
        { pkgs, ... }:
        {
          wsl = {
            enable = true;
            defaultUser = "n3rsti";
            startMenuLaunchers = true;
          };

          home-manager.users.n3rsti = {
            imports = [
              self.homeModules.git
              self.homeModules.zsh
              self.homeModules.neovim
            ];

            home.username = "n3rsti";
            home.homeDirectory = "/home/n3rsti";
            home.stateVersion = "24.11";
          };

          users.users.n3rsti = {
            isNormalUser = true;
            description = "n3rsti";
            shell = pkgs.zsh;
            extraGroups = [ "wheel" ];
          };

          networking.hostName = "wsl";

          system.stateVersion = "24.11";
        }
      )
    ];
  };
}
