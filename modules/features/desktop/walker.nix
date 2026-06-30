{ inputs, ... }:
{
  flake.homeModules.walker =
    { lib, pkgs, ... }:
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
          selection_wrap = true;

          keybinds = {
            next = [
              "Tab"
              "Down"
              "alt Tab"
            ];
            previous = [
              "shift ISO_Left_Tab"
              "alt shift ISO_Left_Tab"
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
              "websearch"
            ];
            max_results_provider = {
              symbols = 100;
            };
          };
        };
      };
      home.activation.elephant-restart = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.systemd}/bin/systemctl --user restart elephant
      '';

    };
}
