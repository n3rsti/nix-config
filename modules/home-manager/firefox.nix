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
        preConfig = builtins.readFile "${pkgs.unstable.arkenfox-userjs}/user.js";
        search = {
          default = lib.mkDefault "ddg";
          privateDefault = lib.mkDefault "ddg";
        };
        extraConfig = ''
          user_pref("browser.startup.page", 1);
          user_pref("browser.startup.homepage", "https://github.com/n3rsti|https://mail.proton.me|https://chatgpt.com|https://ekursy.put.poznan.pl/");

          user_pref("sidebar.verticalTabs", true);
          user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // [DEFAULT: true]
        '';
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
