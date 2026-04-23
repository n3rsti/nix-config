{
  pkgs,
  ...
}:

{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    font = {
      name = "Adwaita Sans Regular";
      package = pkgs.adwaita-fonts;
      size = 11;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 24;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # Fix spotify icon for quickshell tray menu
  home.file.".local/share/icons/hicolor/32x32/apps/spotify-linux-32.png".source =
    "${pkgs.spotify}/share/spotify/icons/spotify-linux-32.png";

  home.sessionVariables = {
    XCURSOR_SIZE = 32;
    HYPRCURSOR_SIZE = 32;
  };
}
