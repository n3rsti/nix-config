{
  imports = [
    ./base.nix
    ../boot/systemd-boot.nix
    ../networking/openssh.nix
    ../networking/tailscale
    ../virtualisation/docker.nix
  ];
}
