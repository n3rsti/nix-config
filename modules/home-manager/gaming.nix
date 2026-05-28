{
  pkgs,
  ...
}:
{
  programs = {
    mangohud.enable = true;
    lutris.enable = true;
  };

  home.packages = with pkgs; [
    mangojuice # Control mangohud
    wineWow64Packages.staging
    unstable.winetricks
    protonup-ng # Proton utilities
    (heroic.override { extraPkgs = pkgs: [ pkgs.gamescope ]; })
    unstable.prismlauncher
    r2modman # mod manager for games
  ];

}
