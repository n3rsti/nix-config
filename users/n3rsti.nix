{
  pkgs,
  ...
}:
{
  users.users.n3rsti = {
    isNormalUser = true;
    description = "n3rsti";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "ydotool"
      "docker"
      "dialout"
      "input"
      "gamemode"
      "kvm"
      "libvirtd"
      "stlink"
      "i2c"
    ];
  };

  home-manager.users.n3rsti = {
    imports = [ ../homes/n3rsti/n3rsti.nix ];
  };
}
