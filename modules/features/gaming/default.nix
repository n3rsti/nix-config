{
  flake.nixosModules.gaming = _: {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      gamemode.enable = true;
      gamescope.enable = true;
    };
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      programs = {
        mangohud.enable = true;
        lutris.enable = true;
        prismlauncher = {
          enable = true;
          package = pkgs.unstable.prismlauncher;
        };
      };

      home.packages = with pkgs; [
        mangojuice # Control mangohud
        wineWow64Packages.staging
        unstable.winetricks
        protonup-ng # Proton utilities
        (heroic.override { extraPkgs = pkgs: [ pkgs.gamescope ]; })
        r2modman # mod manager for games
      ];

      home.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };
    };
}
