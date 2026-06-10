{
  pkgs,
  ...
}:
{

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    font-awesome
    nerd-fonts.space-mono
    nerd-fonts.zed-mono
    nerd-fonts.im-writing
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.adwaita-mono
    icomoon-feather
    adwaita-fonts
  ];
}
