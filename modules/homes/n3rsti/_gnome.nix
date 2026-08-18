{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.appindicator
    pkgs.unstable.gnomeExtensions.media-controller
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.brightness-control-using-ddcutil
    pkgs.unstable.gnomeExtensions.transparent-windows
    pkgs.gnomeExtensions.rounded-window-corners-reborn
  ];

  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.appindicator.extensionUuid
          pkgs.unstable.gnomeExtensions.media-controller.extensionUuid
          pkgs.gnomeExtensions.dash-to-dock.extensionUuid
          pkgs.gnomeExtensions.brightness-control-using-ddcutil.extensionUuid
          pkgs.unstable.gnomeExtensions.transparent-windows.extensionUuid
          pkgs.gnomeExtensions.rounded-window-corners-reborn.extensionUuid
        ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
        num-workspaces = 9;
      };

      "org/gnome/shell/extensions/media-controller" = {
        panel-position = "center";
        panel-text-width = 130;
        scroll-text = false;
        show-next = false;
        show-play-pause = false;
        show-previous = false;
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];

        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-6 = [ "<Super>6" ];
        switch-to-workspace-7 = [ "<Super>7" ];
        switch-to-workspace-8 = [ "<Super>8" ];
        switch-to-workspace-9 = [ "<Super>9" ];

        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        move-to-workspace-9 = [ "<Super><Shift>9" ];
      };

      "org/gnome/extensions/dash-to-dock" = {
        hot-keys = false;
        transparency-mode = "DYNAMIC";
        click-action = "minimize";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.2;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        www = [ "<Super>f" ];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ghostty" = {
        name = "Launch Ghostty";
        command = "ghostty";
        binding = "<Super>t";
      };

      "org/gnome/extensions/display-brightness-ddcutil" = {
        button-location = 1;
        ddcutil-sleep-multiplier = 4.0;
        position-system-menu = 3.0;
        show-display-name = false;
        show-value-label = false;
      };

      "org/gnome/extensions/transparent-windows" = {
        active-window-opacity = 95;
        inactive-window-opacity = 90;
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        delay = lib.hm.gvariant.mkUint32 200;
        repeat-interval = lib.hm.gvariant.mkUint32 40;
      };

      "org/gnome/extensions/blur-my-shell/applications" = {
        blur = true;
        dynamic-opacity = false;
        enable-all = true;
        opacity = 255;
        pipeline = "pipeline_default";
        static-blur = false;
      };
    };
  };
}
