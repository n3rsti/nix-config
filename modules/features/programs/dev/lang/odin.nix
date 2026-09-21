{
  flake.homeModules.odin = { pkgs, ... }: {
    home.packages = with pkgs.unstable; [
      odin
      ols
    ];
  };
}
