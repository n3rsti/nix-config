{
  config,
  dotfilesPath,
  ...
}:
let
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
      value.source = link "${dotfilesPath}/apps/icons/${name}";
    }) icons
  );

  appLinks = builtins.listToAttrs (
    map (name: {
      name = "applications/${name}.desktop";
      value.source = link "${dotfilesPath}/apps/${name}.desktop";
    }) apps
  );
in
{
  xdg.dataFile = iconLinks // appLinks;
}
