{
  flake.homeModules.session = _: {
    services.polkit-gnome.enable = true;

  };
}
