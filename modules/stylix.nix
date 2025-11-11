{
  pkgs,
  lib,
  config,
  ...
}:
let
  themes = {
    catppucin = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      cursor = {
        name = "Catppuccin-Mocha-Blue";
        package = pkgs.catppuccin-cursors.mochaBlue;
      };
    };
    rose-pine = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
    };

    #TODO: Add more themes here
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base00";
    inherit (themes.catppucin) base16Scheme;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}
