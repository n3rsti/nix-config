{ self, ... }:
{
  flake.nixosModules.base = {
    imports = [
      self.nixosModules.unstable
      self.nixosModules.nur
      self.nixosModules.sops
      self.nixosModules.home-manager
      self.nixosModules.locale
      self.nixosModules.nix
      self.nixosModules.shell
    ];
  };

  flake.homeModules.base = {
    imports = [
      self.homeModules.git
      self.homeModules.zsh
      self.homeModules.cli-core
    ];

    programs.home-manager.enable = true;
  };
}
