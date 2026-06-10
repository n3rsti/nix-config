{

  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
  };

  home.packages = with pkgs; [
    pdfgrep # PDF grepping utility for opencode
    ocrmypdf # OCR for pdfs
    qpdf
    mupdf
  ];
}
