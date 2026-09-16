{
  flake.homeModules.csharp = { pkgs, ... }: {
    home.packages = with pkgs; [
      dotnet-sdk_9
      csharp-ls
      roslyn-ls
    ];
  };
}
