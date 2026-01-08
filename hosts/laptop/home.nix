{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Import the default home configuration
  imports = [
    ../default/home.nix
  ];

  # Laptop-specific home-manager configurations
  # Example overrides or additional settings:
  # programs.vscode.enable = true;

  # You can override settings from default home.nix here
  # For example:
  # home.packages = with pkgs; [
  #   # Laptop-specific packages
  #   tlp-ui
  #   powertop
  # ];

  # Example of laptop-specific power management settings
  # services.battery-notifier.enable = true;
}
