{ inputs, ... }: {
  flake.homeModules.theme =
    {
      pkgs,
      config,
      ...
    }:
    {

      imports = [
        inputs.stylix.homeModules.stylix
      ];

      stylix = {
        enable = true;

        # Prevent styling unrelated programs and Hyprland dotfiles.
        autoEnable = false;

        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
        };

        icons = {
          enable = true;
          package = pkgs.adwaita-icon-theme;
          dark = "Adwaita";
          light = "Adwaita";
        };

        fonts = {
          sansSerif = {
            package = pkgs.adwaita-fonts;
            name = "Adwaita Sans";
          };

          serif = {
            package = pkgs.adwaita-fonts;
            name = "Adwaita Sans";
          };

          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };

          sizes.applications = 11;
        };

        targets = {
          gnome.enable = true;
          gtk.enable = true;
          qt.enable = true;
        };
      };
    };
}
