{
  flake.homeModules.session =
    { osConfig, lib, ... }:
    {
      services.polkit-gnome.enable = true;

    };
}
