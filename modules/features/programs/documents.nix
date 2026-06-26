{
  flake.homeModules.documents =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        gimp
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pl_PL
        imagemagick # To show images in neovim
        papers # pdf viewer
        poppler-utils
        unstable.libreoffice-qt6-fresh
      ];

      programs = {
        onlyoffice.enable = true;
        foliate.enable = true; # Ebook reader
      };
    };
}
