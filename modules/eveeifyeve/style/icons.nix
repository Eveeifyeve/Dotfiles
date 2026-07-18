{ lib, ... }:
{
  home.gui =
    { pkgs, ... }:
    {
      stylix.icons = lib.mkIf pkgs.stdenv.isLinux {
        enable = true;
        dark = "catppuccin-mocha";
        light = "catppuccin-latte";
        package = pkgs.catppuccin-icon-theme;
      };
    };
}
