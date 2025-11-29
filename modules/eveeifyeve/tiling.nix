{ lib, ... }:
{
  home.gui =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isDarwin {
      programs.aerospace.settings = {
        enable-normalization-flatten-containers = true;
        automatically-unhide-macos-hidden-apps = true;
        enable-normalization-opposite-orientation-for-nested-containers = true;
        accordion-padding = 30;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";

        on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
        on-focus-changed = [ "move-mouse window-lazy-center" ];

        gaps =
          let
            generalgap = 15;
          in
          {
            inner = {
              horizontal = generalgap;
              vertical = generalgap;
            };
            outer = {
              left = generalgap + 55;
              bottom = generalgap;
              top = generalgap;
              right = generalgap;
            };
          };

        mode.main.binding = {
          alt-t = "exec-and-forget ghostty";
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";
          alt-shift-f = "fullscreen";
        }
        // builtins.listToAttrs (
          builtins.concatLists (
            builtins.genList (i: [
              {
                name = "alt-${toString i}";
                value = "workspace ${toString i}";
              }
              {
                name = "alt-shift-${toString i}";
                value = "move-node-to-workspace ${toString i}";
              }
            ]) 10
          )
        );

      };
    };
}
