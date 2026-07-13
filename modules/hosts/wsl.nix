{ inputs, self, ... }:
{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.base
      self.nixosModules.dev
      self.nixosModules.ssh-agent

      (
        { pkgs, ... }:
        {
          wsl = {
            enable = true;
            defaultUser = "n3rsti";
            startMenuLaunchers = true;
            useWindowsDriver = true;
            docker-desktop.enable = true;
            # Temporary fix. Apparently only need install and mv. Should be fixed in the next release
            extraBin = with pkgs; [
              { src = "${coreutils}/bin/install"; }
              { src = "${coreutils}/bin/mv"; }
            ];
          };

          home-manager.users.n3rsti = {
            imports = [
              self.homeModules.base
              self.homeModules.neovim
              self.homeModules.dev
            ];

            programs.git.settings.user.email = "krzysztof.witucki@asseco.pl";

            dev.java.enable = true;
            dev.javascript.enable = true;
            dev.python.enable = true;

            home.sessionPath = [
              "$HOME/sakctl"
            ];

            home.username = "n3rsti";
            home.homeDirectory = "/home/n3rsti";
            home.stateVersion = "24.11";
          };

          programs.nix-ld.libraries = with pkgs; [
            libxcrypt
            libxcrypt-legacy
            stdenv.cc.cc
            zlib
            openssl
          ];

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
