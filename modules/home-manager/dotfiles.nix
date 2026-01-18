{
  config,
  ...
}:
let
  symlinkRoot = "${config.home.homeDirectory}/.config/dotfiles";
  link = config.lib.file.mkOutOfStoreSymlink;
  icons = [
    "nixos-logo.png"
    "awakened.png"
    "hyprland-logo.png"
    "neovim-logo.png"
    "nixos-logo-white.png"
  ];

  apps = [
    "awakened-poe-trade"
    "change-wallpaper"
    "hyprland-wiki"
    "nix-packages"
    "nixos-options"
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
    "waybar" = {
      source = link "${symlinkRoot}/waybar";
      recursive = true;
    };

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

    "rofi" = {
      source = link "${symlinkRoot}/rofi";
      recursive = true;
    };

    "swayosd" = {
      source = link "${symlinkRoot}/swayosd";
      recursive = true;
    };

    "swaync" = {
      source = link "${symlinkRoot}/swaync";
      recursive = true;
    };

    "quickshell" = {
      source = link "${symlinkRoot}/quickshell";
      recursive = true;
    };
  };
  home.file.".tmux.conf".source = link "${symlinkRoot}/tmux/tmux.conf";

  xdg.dataFile = iconLinks // appLinks;

}
