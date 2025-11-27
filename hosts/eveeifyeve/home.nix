{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ../../modules/homemanager
    ../../modules/homemanager/terminal.nix
    ../../modules/homemanager/eww.nix
    ../../modules/homemanager/git.nix
  ];

  programs.niri.settings = with config.lib.niri.actions; {
    # Monitor configuration
    layout.border.width = 1;
    outputs."HDMI-A-1" = {
      enable = true;
    };

    workspaces = {
      "main" = {
        open-on-output = "HDMI-A-1"; # "HDMI-A-1" (external)
      };
    };

    spawn-at-startup = [
      {
        argv = [
          "wl-paste"
          "--type"
          "text"
          "watch"
          "cliphist"
          "store"
        ];
      }
      {
        argv = [
          "wl-paste"
          "--type"
          "image"
          "watch"
          "cliphist"
          "store"
        ];
      }
      {
        argv = [
          "eww"
          "open"
          "bar"
        ];
      }
    ];

    window-rules = [
      {
        geometry-corner-radius =
          let
            corners = [
              "bottom-left"
              "bottom-right"
              "top-left"
              "top-right"
            ];
            radius = 10.0;
          in
          lib.genAttrs corners (lib.const radius);
        clip-to-geometry = true;
        draw-border-with-background = false;
      }
      { shadow.enable = true; }
      {
        matches = [
          { app-id = "vesktop"; }
        ];
        block-out-from = "screencast";
      }
    ];

    binds =
      let
        workspaces = builtins.genList (i: {
          key = builtins.toString (lib.trivial.mod (i + 1) 10);
          index = i + 1;
        }) 10;

        workspaceBindings =
          # Focus workspace (e.g. Mod+1, Mod+2)
          (map (w: {
            name = "Mod+" + w.key;
            value = {
              action.focus-workspace = w.index;
            };
          }) workspaces)
          ++
            # Move windows to workspace (e.g. Mod+Shift+1, Mod+Shift+2)
            (map (w: {
              name = "Mod+Shift+" + w.key;
              value = {
                action.move-window-to-workspace = w.index;
              };
            }) workspaces);
      in
      lib.mergeAttrsList [
        {
          "XF86AudioPlay".action = spawn "playerctl" "play-pause";
          "XF86AudioPause".action = spawn "playerctl" "pause";
          "XF86AudioNext".action = spawn "playerctl" "next";
          "XF86AudioPrev".action = spawn "playerctl" "previous";
          "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
          "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        }
        (builtins.listToAttrs workspaceBindings)
        {
          "Mod+Escape".action = quit;
          "Mod+H".action = focus-column-or-monitor-left;
          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+L".action = focus-column-or-monitor-right;
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+J".action = move-column-to-workspace-down;
          "Mod+Shift+K".action = move-column-to-workspace-up;
          "Mod+Shift+L".action = move-column-right;
        }
        {
          "Mod+T".action = spawn "ghostty";
          "Mod+E".action = spawn "nautilus";
          "Mod+Space".action = spawn "rofi" "-show" "drun";
          "Mod+F".action = toggle-window-floating;
          "Mod+Shift+F".action = fullscreen-window;
          "Print".action =
            spawn-sh ''${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp} -d)\" - | wl-copy'';
          "Alt+R".action =
            spawn-sh ''${lib.getExe pkgs.wl-screenrec} -g \"$(${lib.getExe pkgs.slurp})\" -f ~/Video/Recording-$(date +%Y-%m-%d_%H-%S).mp4 --audio'';
          "Alt+S".action = spawn "pkill" "--signal" "wl-screenrec";
          "Mod+Q" = {
            repeat = false;
            action = close-window;
          };
        }
      ];

  };

  systemd.user.startServices = true;
  stylix.targets.zen-browser.profileNames = [ "default" ];
  programs = {
    rofi = {
      enable = true;
      location = "center";
      extraConfig = {
        show-icons = true;
      };
    };

    zen-browser = {
      enable = true;
      profiles."default" = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          #dark-reader
          #wappalyzer
        ];
      };
    };
    ghostty = {
      enable = true;
      settings = {
        gtk-titlebar = false;
        gtk-adwaita = false;
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        distroav
      ];
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 1800;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1810;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 3600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
    swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 0;
        control-center-margin-bottom = 0;
        control-center-margin-right = 0;
        control-center-margin-left = 0;
        notification-2fa-action = true;
        notification-inline-replies = false;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
      };
      style = ''
        				.notification-row {
        outline: none;
        				}

        			.notification-row:focus,
        				.notification-row:hover {
        background: @noti-bg-focus;
        				}

        			.notification {
        				border-radius: 12px;
        margin: 6px 12px;
        				box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
        					0 2px 6px 2px rgba(0, 0, 0, 0.3);
        padding: 0;
        			}
        			'';
    };
    hyprpaper.enable = true;
    lorri = {
      enable = true;
      enableNotifications = true;
    };
  };

  gtk.enable = true;

  services.cliphist.enable = true;
  services.amberol.enable = true;
  services.mpd.enable = true;
  xdg.userDirs.enable = true;
  services.mpd-mpris.enable = true;
  services.mpd-discord-rpc = {
    enable = true;
    settings = {
      hosts = [ "localhost:6600" ];
      format = {
        details = "$title";
        state = "$artist";
        timestamp = "elapsed";
      };
    };
  };

  xdg.enable = true;
  xdg.desktopEntries.vesktop = {
    name = "discord";
    exec = "${lib.getExe pkgs.vesktop} --enable-features=UseOzonePlatform --ozone-platform=wayland";
    icon = "${pkgs.discord}/share/icons/hicolor/256x256/apps/discord.png";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
  };

  home = {
    username = "eveeifyeve";
    stateVersion = "25.11";
    packages =
      pkgs.callPackage ../packages.nix { inherit inputs; }
      ++ (with pkgs; [
        podman-desktop
        podman-compose
        pciutils
        pavucontrol
        playerctl
        nautilus
        element-desktop
        libnotify
        wl-clipboard
        lmms
        gparted
        blender
        tor-browser
        anydesk
        lunar-client
        streamdeck-ui
      ]);
    shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#eveeifyeve --json |& nom --json";
  };
}
