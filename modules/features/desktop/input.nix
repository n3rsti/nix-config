{
  flake.nixosModules.input = _: {
    programs = {
      dconf.enable = true;

      ydotool = {
        enable = true;
        group = "users";
      };
    };
  };
}
