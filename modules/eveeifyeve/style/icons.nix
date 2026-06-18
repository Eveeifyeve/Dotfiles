{ lib, ... }:
{
  home.gui =
    { pkgs, ... }:
    {
      stylix.icons = lib.mkIf pkgs.stdenv.isLinux {
        enable = true;
        dark = "rose-pine-icons";
        light = "rose-pine-dawn-icons";
        package = pkgs.rose-pine-icon-theme;
      };
    };
}
