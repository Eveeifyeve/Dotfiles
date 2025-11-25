{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  hypr-plugin = inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ../../modules/homemanager
    ../../modules/homemanager/terminal.nix
    ../../modules/homemanager/eww.nix
    ../../modules/homemanager/git.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    settings = {
      monitor = "HDMI-A-1, highres, 0x0, 1, bitdepth, 8";
      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 4;
        };
      };
      #	animation = {
      #		enabled = true;
      #	};

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
      "$altmod" = "SUPER ALT";
      "exec-once" = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "eww open bar"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "SHIFT, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
        "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Window moving and resizing
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Vim keybind to move windows
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$altmod, H, movewindow, l"
        "$altmod, J, movewindow, d"
        "$altmod, K, movewindow, u"
        "$altmod, L, movewindow, r"
      ]
      ++ [
        "$mod, ESC, exit"
        "$mod, T, exec, ghostty"
        "$mod, Q, killactive"
        "$mod, E, exec, nautilus"
        "$mod, F, togglefloating"
        "$mod, Space, exec, rofi -show drun"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        '', Print, exec, ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -d)" - | wl-copy''
        ''$altmod, R, exec, ${lib.getExe pkgs.wl-screenrec} -g "$(${lib.getExe pkgs.slurp})" -f ~/Video/Recording-$(date +%Y-%m-%d_%H-%S).mp4 --audio''
        ''$altmod, S, exec, pkill --signal wl-screenrec''
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          x:
          let
            ws = builtins.toString (x + 1);
          in
          [
            "$mod, ${ws}, workspace, ${ws}"
            "$shiftMod, ${ws}, movetoworkspace, ${ws}"
            "$altmod, ${ws}, movetoworkspacesilent, ${ws}"
          ]
        ) 9
      ));
    };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  systemd.user.startServices = true;

  programs = {
    rofi = {
      enable = true;
      location = "center";
      extraConfig = {
        show-icons = true;
      };
    };

    # zen-browser = {
    #   enable = true;
    #   profiles."default" = {
    #     extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
    #       ublock-origin
    #       #dark-reader
    #       wappalyzer
    #     ];
    #   };
    # };
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
    waybar = {
      enable = false;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "HDMI-A-1"
          ];

          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
            "wlr/taskbar"
          ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "mpd"
            "wireplumber"
            "clock"
            "custom/power"
          ];

          "hyprland/workspaces" = {
            format = "{icon}";
            on-scoll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          "custom/power" = {
            format = "";
            tooltip = false;
            menu = "on-click";
            menu-file = ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
              	<object class="GtkMenu" id="menu">
              	<child>
              		<object class="GtkMenuItem" id="suspend">
              			<property name="label">Suspend</property>
              				</object>
              	</child>
              	<child>
              				<object class="GtkMenuItem" id="hibernat">
              			<property name="label">Hibernate</property>
              				</object>
              	</child>
              		<child>
              				<object class="GtkMenuItem" id="shutdown">
              			<property name="label">Shutdown</property>
              				</object>
              		</child>
              		<child>
              			<object class="GtkSeparatorMenuItem" id="delimiter1"/>
              		</child>
              		<child>
              		<object class="GtkMenuItem" id="reboot">
              			<property name="label">Reboot</property>
              		</object>
              		</child>
              	</object>
              </interface>
            '';
            menu-actions = {
              shutdown = "shutdown";
              reboot = "reboot";
              suspend = "systemctl suspend";
              hibernate = "systemctl hibernate";
            };
          };
        };
      };
      systemd.enable = true;
    };
    hyprlock.enable = true;
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
