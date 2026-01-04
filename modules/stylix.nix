{
  pkgs,
  lib,
  config,
  ...
}:
let
  themes = {
    catppucin = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
      cursor = {
        name = "Catppuccin-Latte-Blue";
        package = pkgs.catppuccin-cursors.latteBlue;
      };
    };
    rose-pine = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
    };

    tokyo-night = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
      cursor = null;
    };

    #TODO: Add more themes here
  };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "light";
    image = config.lib.stylix.pixel "base00";
    inherit (themes.tokyo-night) base16Scheme;
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
