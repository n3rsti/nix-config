{
  flake.nixosModules.plymouth =
    {
      pkgs,
      ...
    }:
    {
      boot = {
        plymouth = {
          enable = true;
          theme = "red_loader";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "red_loader" ];
            })
          ];
        };

        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = 0;
      };
    };
}
