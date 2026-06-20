{
  homeManager.modules.base =
    { pkgs, ... }:
    {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = pkgs.stdenv.isLinux;
      };
    };
}
