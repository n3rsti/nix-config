{ config, pkgs, ... }:

{
  # Import the default home configuration
  imports = [ ../default/home.nix ];

  sops.secrets.id_pc = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0600";
  };

  # PC-specific home-manager configurations
  # Example overrides or additional settings:
  # programs.vscode.enable = true;

  # You can override settings from default home.nix here
  # For example:
  # home.packages = with pkgs; [
  #   # PC-specific packages
  #   openrgb
  #   piper
  # ];
}
