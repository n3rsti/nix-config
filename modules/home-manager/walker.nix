{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.walker.homeManagerModules.default
  ];
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      hotreload_theme = true;
      theme = "default";
      force_keyboard_focus = true;
      timeout = 60;
      debug = true;

      keybinds = {
        next = [ "Tab" ];
        previous = [ "shift ISO_Left_Tab" ];
      };

      providers = {
        default = [
          "desktopapplications"
          "calc"
          "menus"
        ];
      };
    };
  };

}
