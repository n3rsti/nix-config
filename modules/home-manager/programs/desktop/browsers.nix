{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.browsers;
in
{
  options.profile.programs.desktop.browsers.enable = lib.mkEnableOption "desktop browsers";

  config = lib.mkIf cfg.enable {
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
