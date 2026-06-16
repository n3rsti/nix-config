{ lib, ... }:
{
  imports = [
    ../desktop
    ../programs
    ../dev
    ./gaming.nix
  ];

  dev.kotlin.enable = false;

  profile.programs = {
    cli = {
      core.enable = lib.mkDefault true;
      desktop.enable = lib.mkDefault true;
    };

    desktop = {
      enable = lib.mkDefault true;
      browsers.enable = lib.mkDefault true;
      communication.enable = lib.mkDefault true;
      documents.enable = lib.mkDefault true;
      maker.enable = lib.mkDefault true;
      media.enable = lib.mkDefault true;
      network.enable = lib.mkDefault true;
      productivity.enable = lib.mkDefault true;
    };
  };
}
