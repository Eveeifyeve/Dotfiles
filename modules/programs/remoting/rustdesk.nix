{ lib, ... }:
{
  #TODO: fix rustdesk-flutter darwin support.
  darwin.modules.gui = {
    homebrew.casks = [ "rustdesk" ];
  };

  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = lib.mkIf pkgs.stdenv.isLinux [
        pkgs.rustdesk-flutter
      ];
    };
}
