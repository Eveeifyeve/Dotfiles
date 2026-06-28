{ lib, ... }:
{
  darwin.modules.gui = {
    homebrew.casks = [ "lmms" ];
  };
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = lib.optionals pkgs.stdenv.isLinux [ pkgs.lmms-full ];
    };
}
