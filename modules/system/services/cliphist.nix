{ lib, ... }:
{
  homeManager.modules.base =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isLinux {
      services.cliphist.enable = true;
    };
}
