{
  flake.homeModules.opencode =
    {

      pkgs,
      ...
    }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        enableMcpIntegration = true;

        extraPackages = [
          pkgs.mcp-nixos
        ];
      };

      programs.mcp = {
        enable = true;

        servers.nixos = {
          command = "mcp-nixos";
        };
      };

      home.packages = with pkgs; [
        pdfgrep # PDF grepping utility for opencode
        ocrmypdf # OCR for pdfs
        qpdf
        mupdf
      ];
    };
}
