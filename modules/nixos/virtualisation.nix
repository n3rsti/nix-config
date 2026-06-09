_: {
  virtualisation = {
    libvirtd = {
      qemu = {
        swtpm.enable = true; # Enable TPM emulation
      };
      enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
}
