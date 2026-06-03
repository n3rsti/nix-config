{
  config,
  ...
}:
{
  imports = [
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/walker.nix
    ../../modules/home-manager/dotfiles.nix
    ../../modules/home-manager/desktop.nix
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/noctalia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/opencode.nix
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  home.username = "n3rsti";
  home.homeDirectory = "/home/n3rsti";

  services = {
    tailscale-systray.enable = true;
    protonmail-bridge.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true;
    thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
    };
  };

  accounts.email.accounts = {
    protonmail = {
      primary = true;
      address = "n3rsti@protonmail.com";
      userName = "n3rsti@protonmail.com";
      realName = "Krzysztof Witucki";
      aliases = [
        "n3rsti@pm.me"
        "kwitucki@protonmail.com"
      ];
      imap = {
        host = "127.0.0.1";
        port = 1143;
        authentication = "plain";
        tls.useStartTls = true;
      };

      smtp = {
        host = "127.0.0.1";
        port = 1025;
        authentication = "plain";
        tls.useStartTls = true;
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };
    };

    zimbra = {
      address = "krzysztof.witucki@student.put.poznan.pl";
      userName = "krzysztof.witucki@student.put.poznan.pl";
      realName = "Krzysztof Witucki";
      imap = {
        host = "poczta.student.put.poznan.pl";
        port = 143;
        authentication = "plain";
        tls.useStartTls = true;
      };

      smtp = {
        host = "poczta.student.put.poznan.pl";
        port = 587;
        authentication = "plain";
        tls.useStartTls = true;
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
