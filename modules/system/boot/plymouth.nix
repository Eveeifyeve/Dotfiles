{
  nixos.modules.base = {
    boot.plymouth = {
      enable = true;
    };
  };
}
