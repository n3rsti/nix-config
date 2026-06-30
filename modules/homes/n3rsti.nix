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

    webApps = [
      {
        name = "JakDojade";
        url = "https://jakdojade.pl/lista-miast";
        sha256 = "sha256-B289FyJverdY1yXoS4dJS8xlOl3EsstbZzjy4wTZjeM=";
      }
      {
        name = "Hyprland wiki";
        url = "https://wiki.hypr.land";
        sha256 = "sha256-SB9Q6M+JG3A/T+2e909lc4jujnnIWfT6XTySx9/bLhU=";
      }
      {
        name = "Nix packages";
        url = "https://search.nixos.org/packages";
        sha256 = "sha256-JopfYL/FCA4H4oK9MHWUPr1LVIRSB/ugDhgVsudHmxA=";
      }
      {
        name = "Mynixos";
        url = "https://mynixos.com/options";
        sha256 = "sha256-pVJ92BP+ZVrMbJXYqpTasm8tgrnMdfJ7mlgFZNDG5XM=";
      }

      {
        name = "Youtube";
        url = "https://youtube.com";
        sha256 = "sha256-y2rbGYQ7ZFvCJxgfUnRvAemo/abBEzjKwjxZd8fSOGw=";
      }
    ];
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
