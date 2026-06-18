{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      programs.aerospace = lib.mkIf pkgs.stdenv.isDarwin {
        enable = true;
        launchd.enable = true;
      };
    };
}
