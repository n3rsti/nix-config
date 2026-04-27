{
  osConfig,
  ...
}:
{
  imports = [
    # Include modules common to all configurations
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/walker.nix
    ../../modules/home-manager/dotfiles.nix
    ../../modules/home-manager/desktop.nix
    ../../modules/home-manager/packages.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "n3rsti";
  home.homeDirectory = "/home/n3rsti";

  services.swayosd.enable = osConfig.programs.hyprland.enable;
  services.tailscale-systray.enable = true;

  home.sessionVariables = {
    # EDITOR = "emacs";
    #GTK_THEME = "catppuccin-frappe-blue-standard";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager will use the global nixpkgs config since useGlobalPkgs is enabled
  # We don't need to set nixpkgs.config here

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
