{
  pkgs,
  ...
}:
{
  programs.firefox.profiles.default = {
    preConfig = builtins.readFile "${pkgs.unstable.arkenfox-userjs}/user.js";
    extraConfig = ''
      user_pref("browser.startup.page", 1);
      user_pref("browser.startup.homepage", "https://github.com/n3rsti|https://mail.proton.me|https://chatgpt.com|https://ekursy.put.poznan.pl/");

      user_pref("sidebar.verticalTabs", true);
      user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false); // [DEFAULT: true]
    '';
  };
}
