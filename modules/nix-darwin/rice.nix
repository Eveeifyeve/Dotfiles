{ config, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  services.jankyborders = {
    enable = true;
    style = "round";
    width = 5.0;
    hidpi = true;
  };

  services.sketchybar = {
    enable = true;
    config = ''
      sketchybar --bar position=top height=40 blur_radius=30 color=0x${colors.base00}


    '';
  };

}
