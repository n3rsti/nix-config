{
  flake.homeModules.javascript =
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
        home.packages = with pkgs; [
          nodejs_24
          typescript
          eslint
          typescript-language-server
          vscode-langservers-extracted
          python313Packages.cssbeautifier
          python313Packages.jsbeautifier
          tailwindcss-language-server
          prettierd
          emmet-language-server
          emmet-ls
        ];

        programs.zsh.oh-my-zsh.plugins = [ "ng" ];

        home.sessionVariables = {
          NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
        };

        home.sessionPath = [
          "${config.home.homeDirectory}/.npm-global/bin"
        ];
      };
    };
}
