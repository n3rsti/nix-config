{ inputs, self, ... }:
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.base
      self.nixosModules.dev

      (
        { pkgs, ... }:
        {
          wsl = {
            enable = true;
            defaultUser = "n3rsti";
            startMenuLaunchers = true;
            useWindowsDriver = true;
            docker-desktop.enable = true;
          };

          home-manager.users.n3rsti = {
            imports = [
              self.homeModules.git
              self.homeModules.zsh
              self.homeModules.neovim
              self.homeModules.dev
              self.homeModules.cli-core
            ];

            dev.kotlin.enable = false;
            dev.csharp.enable = false;
            dev.rust.enable = false;
            dev.typst.enable = false;
            dev.microcontrollers.enable = false;

            home.sessionPath = [
              "$HOME/sakctl"
            ];

            home.username = "n3rsti";
            home.homeDirectory = "/home/n3rsti";
            home.stateVersion = "24.11";
          };

          dev.microcontrollers.enable = false;

          programs = {
            nix-ld = {
              enable = true;
              libraries = with pkgs; [
                libxcrypt
                libxcrypt-legacy
                stdenv.cc.cc
                zlib
                openssl
              ];

            };

            direnv = {
              enable = true;
              nix-direnv.enable = true;
            };
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
