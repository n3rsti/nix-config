{
  flake.homeModules.browsers =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        chromium
        unstable.brave
      ];

      programs.firefox = {
        enable = true;
        package = pkgs.unstable.firefox;

        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles.default = {
          isDefault = true;
          search = {
            default = lib.mkDefault "ddg";
            privateDefault = lib.mkDefault "ddg";
          };
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            return-youtube-dislikes
            sponsorblock
            ublock-origin
            youtube-shorts-block
          ];
        };
      };
    };
}
