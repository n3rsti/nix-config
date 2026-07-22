{
  flake.nixosModules.nix-tools = { pkgs, ... }: {
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

    environment.systemPackages = with pkgs; [
      nix-tree
    ];
  };
}
