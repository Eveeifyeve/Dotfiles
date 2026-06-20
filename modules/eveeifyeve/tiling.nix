{ lib, ... }:
{
  home.gui =
    { pkgs, config, ... }:
    lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isDarwin {
        #TODO: switch to rift: https://github.com/acsandmann/rift
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

          mode.main.binding = lib.mkMerge [
            {
              alt-t = "exec-and-forget ${config.programs.ghostty.package}";
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
            (lib.foldr (a: b: a // b) { } (
              builtins.concatLists (
                builtins.genList (
                  i:
                  let
                    w = i + 1;
                    key = toString w;
                    n = if w == 10 then "0" else key;
                  in
                  [
                    { ${"alt-" + n} = "workspace ${n}"; }
                    { ${"alt-shift-" + n} = "move-node-to-workspace ${n}"; }
                  ]
                ) 10
              )
            ))
          ];
        };
      })
      (lib.mkIf pkgs.stdenv.isLinux {
        wayland.windowManager.hyprland.settings = {
          general.gaps_in = 15;
          general.gaps_out = "70,15,15,15";
          decoration = {
            rounding = 5;
          };

          dwindle = {
            precise_mouse_move = true;
            preserve_split = true;
            force_split = 2;
            split_bias = 1;
          };

          input.follow_mouse = 1;
          bind = lib.mkMerge [
            [
              "$mainMod, T, exec, ${config.programs.ghostty.package}"

              "$mainMod, H, movefocus, l"
              "$mainMod, J, movefocus, d"
              "$mainMod, K, movefocus, u"
              "$mainMod, L, movefocus, r"

              "$mainMod SHIFT, H, movewindow, l"
              "$mainMod SHIFT, J, movewindow, d"
              "$mainMod SHIFT, K, movewindow, u"
              "$mainMod SHIFT, L, movewindow, r"

              "$mainMod, F, fullscreen, 1"
              "$mainMod SHIFT, F, fullscreen, 2"

              # Layout Switching & Tiling.
              "$mainMod SHIFT, 1, exec, hyprctl keyword general:layout dwindle"
              "$mainMod SHIFT, 2, exec, hyprctl keyword general:layout master"
              "$mainMod SHIFT, 3, exec, hyprctl keyword general:layout togglesplit"
              "$mainMod, P, pseudo"
              "Print, exec, ${lib.getExe pkgs.grim} - | ${lib.getExe pkgs.satty} -f - --copy-command ${pkgs.wl-clipboard-rs}/bin/wl-copy -o '~/Pictures/Screenshots/%Y%m%d_%H%M%S.png'"
            ]
            (builtins.concatLists (
              builtins.genList (
                i:
                let
                  w = i + 1;
                  key = toString w;
                  n = if w == 10 then "0" else key;
                in
                [
                  "$mainMod, ${n}, workspace, ${n}"
                  "$mainMod SHIFT, ${n}, movetoworkspace, ${n}"
                ]
              ) 10
            ))
          ];
        };
      })
    ];
}
