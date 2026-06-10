{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    acpi
    dmidecode
    efibootmgr
    exfatprogs
    parted
    snx-rs
    usbutils
    vulkan-tools
  ];
}
