{
  flake.homeModules.maker =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        caligula # Flashing ISOs
        orca-slicer
      ];
    };
}
