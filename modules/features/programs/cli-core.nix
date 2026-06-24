{
  flake.homeModules.cli-core =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        bc
        btop
        duf
        eza # better ls
        fastfetch
        fd
        fzf
        jq
        lsof
        netcat-gnu
        nmap
        ripgrep
        television # tv
        tmux
        tree
        unzip
        websocat
        wget
        zip
      ];
    };
}
