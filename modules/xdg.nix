{ lib, ... }:
{
  homeManager.modules.base =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isLinux {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;
      };
    };
}
