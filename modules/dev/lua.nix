{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.lua;
in
{
  options.dev.lua = {
    enable = lib.mkEnableOption "Lua development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lua
      stylua
      lua-language-server

      lua54Packages.luarocks
      lua51Packages.tiktoken_core
    ];

  };
}
