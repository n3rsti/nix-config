_: {
  stylix.targets.librewolf = {
    enable = true;
    profileNames = [ "default" ];
    colorTheme.enable = true;
  };

  programs.librewolf.profiles.default = {
    extensions.settings."FirefoxColor@mozilla.com".force = true;

    search = {
      engines.searxng = {
        urls = [
          {
            template = "https://searxng.tail3ce7af.ts.net/search?q={searchTerms}";
          }
        ];
      };
      default = "searxng";
      privateDefault = "searxng";
    };

    settings = {
      "browser.startup.page" = 1;
      "browser.startup.homepage" =
        "https://glance.tail3ce7af.ts.net|https://github.com/n3rsti|https://mail.proton.me|https://chatgpt.com|https://ekursy.put.poznan.pl/";
      "sidebar.verticalTabs" = true;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "devtools.toolbox.host" = "right";
    };
  };

  programs.librewolf.policies.ClearOnShutdown.Exceptions = [
    "https://github.com"
    "https://twitch.tv"
    "https://steamcommunity.com"
    "https://chatgpt.com"
    "https://proton.me"
    "https://protonmail.com"
    "https://accounts.youtube.com"
    "https://pathofexile.com"
  ];
}
