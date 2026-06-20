{
  nixos.modules.base = {
    boot.loader.plymouth = {
      enable = true;
    };
  };
}
