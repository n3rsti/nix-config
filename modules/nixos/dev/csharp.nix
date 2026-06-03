{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.dev.csharp;
in
{
  options.dev.csharp = {
    enable = lib.mkEnableOption "C# development environment";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dotnet-sdk_9
      csharp-ls
      roslyn-ls
    ];

  };
}
