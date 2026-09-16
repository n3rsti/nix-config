{ inputs, ... }:
{
  flake.nixosModules.noctalia = {
    nix = {
      settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };
  };

  flake.homeModules.noctalia =
    {
      pkgs,
      config,
      dotfilesPath,
      ...
    }:

    let
      link = config.lib.file.mkOutOfStoreSymlink;
    in
    {

      imports = [
        inputs.noctalia.homeModules.default
      ];

      home.packages = with pkgs; [
        ddcutil # Monitor brightness
        tesseract # OCR Engine
        zbar # QR/barcode scanning
        translate-shell # OCR Translation
        gpu-screen-recorder # For noctalia-shell
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };

      systemd.user.services.noctalia.Unit.ConditionEnvironment = "XDG_CURRENT_DESKTOP=Hyprland";

      home.file.".config/noctalia/settings.toml".source = link "${dotfilesPath}/noctalia/settings.toml";

      xdg.configFile = {
        "noctalia/palettes" = {
          source = link "${dotfilesPath}/noctalia/palettes";
          recursive = true;
        };
      };

    };
}
