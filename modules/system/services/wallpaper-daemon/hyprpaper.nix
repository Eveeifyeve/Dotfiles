{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isLinux {
      services.hyprpaper.enable = lib.mkDefault true;
    };
}
