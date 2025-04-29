{ config, pkgs, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  services.jankyborders = {
    enable = true;
    style = "round";
    hidpi = true;
  };

  services.sketchybar =
    let
      clock = pkgs.writeShellBinScript ''
        sketchybar --set "clock" label=\"$(date '+%H   :    %M')\"
      '';
    in
    {
      enable = true;
      config = ''
              sketchybar --bar position=left topmost="window" height=42 margin=10 padding_left=4 padding_right=4 corner_radius=10 y_offset=8 border_width=1 border_color=${config.services.jankyborders.active_color}
        			sketchybar --add event aerospace_workspace_change

              sketchybar --update
      '';
    };

  system.activationScripts.postUserActivation.text = ''
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${config.stylix.image}\""
  '';

}
