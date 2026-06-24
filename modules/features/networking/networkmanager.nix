{
  flake.nixosModules.networkmanager =
    {
      lib,
      ...
    }:
    {
      networking.hostName = lib.mkDefault "nixos";

      networking.networkmanager.enable = lib.mkDefault true;

      networking.firewall.allowedTCPPorts = [
        8080
      ];
    };

  flake.homeModules.networkmanager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        networkmanagerapplet # For nm-connection-editor
        nmgui # Wifi gui
      ];
    };
}
