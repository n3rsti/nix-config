{
  config,
  ...
}:
let
  symlinkRoot = "${config.home.homeDirectory}/.config/dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
  icons = [
    "awakened.png"
    "exiled-exchange.png"
    "neovim-logo.png"
    "monitor.png"
    "eye-dropper-solid.png"
  ];

  apps = [
    "awakened-poe-trade"
    "exiled-exchange"
    "monitor-settings"
    "color-picker"
  ];

  iconLinks = builtins.listToAttrs (
    map (name: {
      name = "icons/${name}";
      value.source = link "${symlinkRoot}/apps/icons/${name}";
    }) icons
  );

  appLinks = builtins.listToAttrs (
    map (name: {
      name = "applications/${name}.desktop";
      value.source = link "${symlinkRoot}/apps/${name}.desktop";
    }) apps
  );
in
{
  xdg.configFile = {
    "hypr" = {
      source = link "${symlinkRoot}/hypr";
      recursive = true;
    };

    "nvim" = {
      source = link "${symlinkRoot}/nvim";
      recursive = true;
    };

    "walker/themes" = {
      source = link "${symlinkRoot}/walker/themes";
      recursive = true;
    };

    "zed" = {
      source = link "${symlinkRoot}/zed";
      recursive = true;
    };
  };
  home.file.".config/elephant/websearch.toml".source = link "${symlinkRoot}/elephant/websearch.toml";

  xdg.dataFile = iconLinks // appLinks;

}
