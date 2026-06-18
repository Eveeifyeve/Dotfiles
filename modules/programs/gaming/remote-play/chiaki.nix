{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = lib.mkIf pkgs.stdenv.isLinux [
        pkgs.chiaki-ng
      ];
    };
}
