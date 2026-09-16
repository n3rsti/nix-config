{
  flake.homeModules.nix = { pkgs, ... }: {
    home.packages = with pkgs; [
      nil
      nixfmt
      nixd
    ];
  };
}
