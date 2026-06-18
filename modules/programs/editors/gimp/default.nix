{ lib, ... }:
{
  darwin.modules.gui = {
    homebrew.casks = [ "gimp" ];
  };
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = lib.mkIf pkgs.stdenv.isLinux [ pkgs.gimp ];
    };
}
