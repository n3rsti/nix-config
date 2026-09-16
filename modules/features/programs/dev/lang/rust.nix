{
  flake.homeModules.rust = { pkgs, ... }: {
    home.packages = with pkgs; [
      rustup
      probe-rs-tools
    ];
  };
}
