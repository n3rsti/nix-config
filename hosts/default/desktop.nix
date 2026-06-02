{
  pkgs,
  config,
  inputs,
  ...
}:

let
  pkgs_unstable = (
    import inputs.nixpkgs_unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    package = pkgs_unstable.hyprland;
  };

  # programs.uwsm.waylandCompositors = {
  #   hyprland-uwsm = {
  #     prettyName = "Hyprland (start-hyprland)";
  #     comment = "Hyprland compositor managed by UWSM";
  #     binPath = "/run/current-system/sw/bin/start-hyprland";
  #   };
  # };

  services.displayManager.sddm = {
    enable = true;
    theme = "pixie";
    wayland.enable = true; # Optional: for Wayland sessions
    settings = {
      Theme = {
        CursorTheme = "Adwaita";
      };
    };

    # Crucial for Qt6: Use the KDE/Qt6 build of SDDM to fix missing
    # cursors and module errors.
    package = pkgs.kdePackages.sddm;

    # Required dependencies for Qt6 themes
    extraPackages = [
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qt5compat
      pkgs.adwaita-icon-theme
    ];
  };

  environment.systemPackages = [
    # Install and customize the theme. All fields are optional and will
    # fall back to theme defaults if not set.
    (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
      background = ./wallpaper.jpg; # Nix path or absolute path
      avatar = ./avatar.png; # Nix path or absolute path
      primaryColor = "#B3C8FF"; # Hex color code
      accentColor = "#3F5F91"; # Hex color code
      autoColor = true; # true/false
      backgroundColor = "#1A1C1E"; # Hex color code
      textColor = "#E2E2E6"; # Hex color code
      fontFamily = "JetBrains Mono"; # Font family name
      fontSize = 13; # Font size in px
    })
  ];

  security.polkit.enable = true;
}
