{ lib, ... }:
#let
#   clock = pkgs: pkgs.writeShellBinScript ''
#     sketchybar --set "clock" label=\"$(date '+%H   :    %M')\"
#   '';
#in
{
  home.gui =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isDarwin {
      programs.sketchybar.config = ''
        		sketchybar --bar position=left topmost="window" height=42 margin=10 padding_left=4 padding_right=4 corner_radius=10 y_offset=8 border_width=1 
        		sketchybar --add event aerospace_workspace_change
        		sketchybar --update
        		'';
    };
}
