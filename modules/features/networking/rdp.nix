{
  flake.homeModules.rdp =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        remmina # Remote Desktop client
      ];
    };
}
