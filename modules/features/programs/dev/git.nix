{
  flake.homeModules.git =
    { lib, ... }:

    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = lib.mkDefault "Krzysztof Witucki";
            email = lib.mkDefault "n3rsti@protonmail.com";
          };
          core.editor = "nvim";
        };
      };
    };
}
