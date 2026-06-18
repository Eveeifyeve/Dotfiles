{ lib, ... }:
{
  home.gui =
    { pkgs, ... }:
    {
      programs.sketchybar = lib.mkIf pkgs.stdenv.isDarwin {
        enable = true;
        service.enable = true;
      };
    };
}
