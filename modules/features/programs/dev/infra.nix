{
  flake.homeModules.infra = { pkgs, ... }: {
    home.packages = with pkgs; [
      terraform
    ];

    programs.zsh.initContent = ''
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C ${pkgs.terraform}/bin/terraform terraform
    '';
  };
}
