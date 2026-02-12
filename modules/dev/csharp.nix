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

      pkgs_stable.dotnet-sdk_9
      pkgs_stable.csharp-ls
      pkgs_stable.roslyn-ls

    ];

  };
}
