{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      n3rsti = {
        isDefault = true;
        preConfig = builtins.readFile "${pkgs.arkenfox-userjs}/user.js";
        search = {
          default = "ddg";
          privateDefault = "ddg";
        };
        extraConfig = ''
          user_pref("browser.startup.page", 1);
          user_pref("browser.startup.homepage", "https://github.com/n3rsti|https://mail.proton.me/u/0/inbox|https://chatgpt.com|https://ekursy.put.poznan.pl/");

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
          ];
        };
      };

    };
  };

}
