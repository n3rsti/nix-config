{ self, ... }:
{
  flake.homeModules.n3rsti = {
    imports = [
      self.homeModules.workstation
      ./n3rsti/_firefox.nix
      ./n3rsti/_dotfiles.nix
      ./n3rsti/_email/protonmail.nix
      ./n3rsti/_email/zimbra.nix
    ];

    home.username = "n3rsti";
    home.homeDirectory = "/home/n3rsti";
    home.stateVersion = "24.11";

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
    };
  };

  flake.homeModules.n3rsti-server = {
    imports = [
      self.homeModules.server
    ];

    home.username = "n3rsti";
    home.homeDirectory = "/home/n3rsti";
    home.stateVersion = "24.11";

  };
}
