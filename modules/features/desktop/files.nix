{
  flake.homeModules.desktop-files =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        baobab # Disk usage analyzer
        gnome-disk-utility # Disks
        resources
        (nautilus.overrideAttrs (old: {
          buildInputs =
            old.buildInputs
            ++ (with gst_all_1; [
              gst-plugins-good
              gst-plugins-bad
              gst-plugins-ugly
              gst-libav
            ]);
        }))
      ];
    };
}
