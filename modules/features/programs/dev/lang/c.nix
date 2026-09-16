{
  flake.homeModules.c = { pkgs, ... }: {
    home.packages = with pkgs; [
      gcc
      clang-tools
      gnumake
      pkg-config
      glsl_analyzer
      bear
    ];
  };
}
