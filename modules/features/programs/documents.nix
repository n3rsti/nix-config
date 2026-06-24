{
  flake.homeModules.documents =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        foliate # Ebook reader
        gimp
        hunspell
        hunspellDicts.en_US
        hunspellDicts.pl_PL
        imagemagick # To show images in neovim
        papers # pdf viewer
        poppler-utils
        unstable.libreoffice-qt6-fresh
        onlyoffice-desktopeditors
      ];
    };
}
