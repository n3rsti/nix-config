{
  flake.homeModules.go = { pkgs, ... }: {
    home.packages = with pkgs; [
      gopls
      delve
    ];

    programs.go = {
      enable = true;
      telemetry.mode = "off";
    };
  };
}
