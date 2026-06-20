{ lib, ... }:
{
  nixos.modules.gui = {
    boot.loader.timeout = lib.mkDefault 0;
  };
}
