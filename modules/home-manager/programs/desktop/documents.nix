{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.profile.programs.desktop.documents;
in
{
  options.profile.programs.desktop.documents.enable =
    lib.mkEnableOption "document and image applications";

  config = lib.mkIf cfg.enable {
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
