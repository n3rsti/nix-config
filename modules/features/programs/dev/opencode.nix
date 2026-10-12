{
  flake.homeModules.opencode =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        enableMcpIntegration = true;

        tui = {
          scroll_acceleration.enabled = true;
        };

        settings = {
          provider.ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama Local";

            options = {
              baseURL = "http://127.0.0.1:11434/v1";
            };

            models = {
              "qwen3.5:9b-q8_0" = {
                name = "Qwen3.5 9B Q8";

                limit = {
                  context = 32768;
                  output = 4096;
                };
              };

              "gpt-oss:20b" = {
                name = "GPT OSS 20B";

                limit = {
                  context = 32768;
                  output = 4096;
                };
              };

              "ministral-3:14b" = {
                name = "Ministral 3 14B";

                limit = {
                  context = 32768;
                  output = 4096;
                };
              };
            };
          };

          permission = {
            webfetch = "allow";
            websearch = "allow";
            bash = "ask";
          };
        };

        extraPackages = [
          pkgs.mcp-nixos
        ];
      };

      programs.mcp = {
        enable = true;

        servers = {
          nixos = {
            command = "mcp-nixos";
          };

          angular-cli = {
            command = "npx";
            args = [
              "-y"
              "@angular/cli"
              "mcp"
            ];
          };

          thunderbird = {
            command = "${pkgs.unstable.thunderbird-mcp}/bin/thunderbird-mcp";
          };

        };
      };

      home.packages = with pkgs; [
        pdfgrep
        ocrmypdf
        qpdf
        mupdf
      ];
    };
}
