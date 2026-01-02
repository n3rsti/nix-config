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
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Fix spotify icon for quickshell tray menu
  home.file.".local/share/icons/hicolor/32x32/apps/spotify-linux-32.png".source =
    "${pkgs.spotify}/share/spotify/icons/spotify-linux-32.png";
}
