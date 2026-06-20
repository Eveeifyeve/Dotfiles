{
  nixos.modules.base = {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      memtest86.enable = true;
    };
  };
}
