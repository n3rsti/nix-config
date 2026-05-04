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
      theme = "launcher";
      force_keyboard_focus = true;

      keybinds = {
        next = [
          "Tab"
          "Down"
        ];
        previous = [
          "shift ISO_Left_Tab"
          "Up"
        ];
        left = [
          "shift ISO_Left_Tab"
          "Left"
        ];
        right = [
          "Tab"
          "Right"
        ];
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
  home.activation.elephant-restart = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.systemd}/bin/systemctl --user restart elephant
  '';

}
