{
  flake.homeModules.lua = { pkgs, ... }: {
    home.packages = with pkgs; [
      lua
      stylua
      lua-language-server
      lua54Packages.luarocks
      lua51Packages.tiktoken_core
    ];
  };
}
