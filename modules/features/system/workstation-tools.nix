{
  flake.nixosModules.workstation-tools = _: {
    programs = {
      nh.enable = true;

      appimage = {
        enable = true;
        binfmt = true;
      };

      nix-ld.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
