{ inputs, ... }:
{
  flake.nixosModules.flatpak = {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      packages = [
        "org.vinegarhq.Sober"
        "com.bambulab.BambuStudio"
        "org.freecad.FreeCAD"
      ];
    };
  };
}
