{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.javascript;
in
{
  options.dev.javascript = {
    enable = lib.mkEnableOption "Javascript / Typescript development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bun
      deno
      nodejs_24
      typescript
      eslint
      typescript-language-server
      vscode-langservers-extracted
      python313Packages.cssbeautifier
      python313Packages.jsbeautifier
      nodePackages.vscode-json-languageserver
      tailwindcss-language-server
      prettierd
    ];

  };
}
