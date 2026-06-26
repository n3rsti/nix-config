{ self, ... }: {
  flake.homeModules.cli-core =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        self.homeModules.tmux
      ];

      home.packages = with pkgs; [
        bc
        duf
        fd
        jq
        lsof
        netcat-gnu
        nmap
        ripgrep
        television # tv
        tree
        unzip
        websocat
        wget
        zip
      ];

      programs = {
        btop.enable = true;
        fastfetch.enable = true;
        fzf = {
          enable = true;
          enableZshIntegration = config.programs.zsh.enable;
        };
        eza = {
          enable = true;
          enableZshIntegration = config.programs.zsh.enable;
        };
      };
    };
}
