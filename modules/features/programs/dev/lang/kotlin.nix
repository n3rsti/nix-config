{
  flake.homeModules.kotlin = { pkgs, ... }: {
    home.packages = with pkgs; [
      kotlin
      kotlin-language-server
      ktlint
      android-studio-full
      androidenv.androidPkgs.platform-tools
      androidenv.androidPkgs.emulator
    ];
  };
}
