{
  flake.homeModules.python = { pkgs, ... }: {
    home.packages = with pkgs; [
      (python3.withPackages (
        ps: with ps; [
          debugpy
          pip
          pygobject3
          dbus-python
          jupytext
        ]
      ))
      basedpyright
      black
    ];
  };
}
