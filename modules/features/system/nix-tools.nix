{
  flake.nixosModules.nix-tools = {
    programs = {
      nh = {
        enable = true;
        flake = "/etc/nixos";
      };

      nix-ld.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
