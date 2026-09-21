{
  inputs,
  self,
  mkNixosSystem,
  ...
}:
{
  flake.nixosConfigurations.wsl = mkNixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.base
      self.nixosModules.ssh-agent
      self.nixosModules.docker

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

            wslConf.interop = {
              enabled = false;
              appendWindowsPath = false;
            };
          };

          virtualisation.docker.logDriver = "json-file";

          home-manager.users.n3rsti = {
            imports = [
              self.homeModules.base
              self.homeModules.neovim
              self.homeModules.dev
              self.homeModules.infra
              self.homeModules.java
              self.homeModules.javascript
              self.homeModules.python
              self.homeModules.zig
              self.homeModules.c
              self.homeModules.go
              self.homeModules.odin
            ];

            programs.git.settings.user.email = "krzysztof.witucki@asseco.pl";

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
