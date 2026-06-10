{
  imports = [
    ./base.nix
    ../boot
    ../desktop
    ../gaming
    ../hardware/mobile-devices.nix
    ../networking
    ../networking/kdeconnect.nix
    ../networking/localsend.nix
    ../networking/tailscale/client.nix
    ../networking/zerotier.nix
    ../system/fonts.nix
    ../system/packages.nix
    ../system/workstation-tools.nix
    ../virtualisation/docker.nix
  ];

  nixpkgs.config.android_sdk.accept_license = true;
}
