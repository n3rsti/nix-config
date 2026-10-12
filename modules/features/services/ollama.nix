{
  flake.nixosModules.ollama = { pkgs, lib, ... }: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;

      host = "127.0.0.1";
      port = 11434;

      loadModels = [ ];

      environmentVariables = {
        OLLAMA_CONTEXT_LENGTH = lib.mkDefault "32768";
        OLLAMA_KEEP_ALIVE = lib.mkDefault "1m";
      };
    };
  };
}
