{
  flake.homeModules.javascript =
    { config, pkgs, ... }:
    {
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
}
