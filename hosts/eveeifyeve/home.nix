{
  config,
  pkgs,
  lib,
  inputs,
  git,
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
      monitor = "HDMI-A-1, preferred, 0x0, 1, bitdepth, 8";
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      #	animation = {
      #		enabled = true;
      #	};

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
      # "$volumeControl" = pkgs.writeShellScript;
      "exec-once" = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "eww open bar"
      ];

      bindl = [
        # ", XF86AudioMute, exec, $volumeControl -o "
        # ", XF86AudioLowerVolume, exec, $volumeControl -o d"
        # ", XF86AudioRaiseVolume, exec, $volumeControl -o i"
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

      bind =
        [
          # Vim keybind to move windows
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
        ]
        ++ [
          "$mod, Q, exec, kitty"
          "$mod, C, killactive"
          "$mod, E, exec, nautilus"
          "$mod, F, togglefloating"
          "$mod, Space, exec, wofi --show drun -I"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          '', Print, exec, grim -g "$(slurp -d)" - | wl-copy''
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            x:
            let
              ws = builtins.toString (x + 1);
            in
            [
              "$mod, ${ws}, workspace, ${ws}"
              "$shiftMod, ${ws}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        ));
    };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  systemd.user.startServices = true;

  programs = {
    wofi = {
      enable = true;
      settings = {
        location = "center";
        alow_markup = true;
        height = 250;
      };
      # Style it like catppucin 
      style = null;
    };
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      shellIntegration.enableZshIntegration = true;
    };
    hyprlock = {
      enable = true;
      settings = {
        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
            shadow_passes = 2;
          }
        ];
      };
    };
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "hyprlock";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "hyprlock";
          }
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
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
    lorri = {
      enable = true;
      enableNotifications = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  services.cliphist.enable = true;
  services.amberol.enable = true;
  services.mpd-discord-rpc.enable = true;

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  xdg.desktopEntries.vesktop = {
    name = "Discord";
    exec = "${lib.getExe pkgs.vesktop} --enable-features=UseOzonePlatform --ozone-platform=wayland";
    icon = "discord";
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
    stateVersion = "24.05";
    packages =
      pkgs.callPackage ../../modules/packages.nix { }
      ++ (with pkgs; [
        pciutils
        firefox
        pavucontrol
        playerctl
        nautilus
        modrinth-app
        element-desktop
        grim
        slurp
        libnotify
        wl-clipboard
      ]);
    shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#eveeifyeve --json |& nom --json";
  };
}
