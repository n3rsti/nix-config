{
  flake.nixosModules.intel =
    {
      pkgs,
      ...
    }:
    {
      hardware = {
        graphics = {
          enable = true;
          extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
            intel-compute-runtime
          ];
        };
        cpu.intel.updateMicrocode = true;
      };

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
      };
    };
}
