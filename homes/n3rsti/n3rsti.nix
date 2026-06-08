{
  ...
}:
{
  imports = [
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/firefox.nix
    ./firefox.nix
    ../../modules/home-manager/walker.nix
    ../../modules/home-manager/dotfiles.nix
    ../../modules/home-manager/desktop.nix
    ../../modules/home-manager/packages.nix
    ../../modules/home-manager/noctalia/noctalia.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/opencode.nix
    ../../modules/home-manager/kdeconnect.nix
    ../../modules/home-manager/dev/default.nix
    ./email/protonmail.nix
    ./email/zimbra.nix
  ];

  home.username = "n3rsti";
  home.homeDirectory = "/home/n3rsti";

  services = {
    tailscale-systray.enable = true;
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

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
