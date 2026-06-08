{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;

    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles = {
      default = {
        isDefault = true;
        search = {
          default = lib.mkDefault "ddg";
          privateDefault = lib.mkDefault "ddg";
        };
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            sponsorblock
            darkreader
            bitwarden
            return-youtube-dislikes
            youtube-shorts-block
          ];
        };
      };

    };
  };

}
