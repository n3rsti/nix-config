{ self, ... }:
{
  flake.homeModules.n3rsti = {
    imports = [
      self.homeModules.workstation-profile
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
        icon = ../../assets/jakdojade.png;
      }
      {
        name = "Hyprland wiki";
        url = "https://wiki.hypr.land";
        icon = ../../assets/hyprland.png;
      }
      {
        name = "Nix packages";
        url = "https://search.nixos.org/packages";
        icon = ../../assets/nixos.png;
      }
      {
        name = "Mynixos";
        url = "https://mynixos.com/options";
        icon = ../../assets/mynixos.png;
      }

      {
        name = "Youtube";
        url = "https://youtube.com";
        icon = ../../assets/youtube.png;
      }
    ];
  };

  flake.homeModules.n3rsti-server = {
    imports = [
      self.homeModules.server-profile
    ];

    home.username = "n3rsti";
    home.homeDirectory = "/home/n3rsti";
    home.stateVersion = "24.11";

  };
}
