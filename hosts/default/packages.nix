{
  pkgs,
  config,
  inputs,
  ...
}:
let
  pkgs_unstable = (
    import inputs.nixpkgs_unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = config.nixpkgs.config;
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    pkgs_unstable.neovim
    duf
    poppler-utils
    ripgrep
    dmidecode
    wget
    tree
    acpi
    btop
    pinentry-gnome3
    fzf
    tmux
    fastfetch
    imagemagick
    nmap
    zip
    unzip
    lsof
    netcat-gnu
    jq
    bc
    fd
    parted
    exfatprogs
    gnome-disk-utility
    usbutils
    libimobiledevice
    snx-rs
    system-config-printer
    btop
    poppler-utils
    acpi
    vulkan-tools
    age
    sops
    sshfs
    efibootmgr
  ];
}
