{
  flake.homeModules.files =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        baobab # Disk usage analyzer
        gnome-disk-utility # Disks
        resources
        gnome-text-editor
        switcheroo # Converting image formats
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
