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

        shadow = {
          enabled = true;
          range = 4;
          render_power = 4;
        };

        blur = {
          enabled = false;
          #  size = 3;
          #  passes = 1;
          #  vibrancy = 0.1696;
        };
      };
      #	animation = {
      #		enabled = true;
      #	};

      "$mod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
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

      bind =
        [
          # Vim keybind to move windows
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
        ]
        ++ [
          "$mod, ESC, exit"
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
    };
    kitty = {
      enable = true;
    };
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        ms-vsliveshare.vsliveshare
        astro-build.astro-vscode
        vscodevim.vim
      ];
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
    dunst = {
      enable = true;
      settings = {
        global = {
          width = 400;
          height = 300;
          offset = "20x40";
          origin = "top-right";
          transparency = 15;
          corner_radius = 7;
        };
      };
    };
    lorri = {
      enable = true;
      enableNotifications = true;
    };
  };

  gtk.iconTheme = {
    package = pkgs.rose-pine-icon-theme;
    name = "rose-pine";
  };

  services.cliphist.enable = true;
  services.amberol.enable = true;
  services.mpd-discord-rpc.enable = true;

  xdg.desktopEntries.vesktop = {
    name = "discord";
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

  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  home = {
    username = "eveeifyeve";
    stateVersion = "24.05";
    packages =
      pkgs.callPackage ../packages.nix { inherit inputs; }
      ++ (with pkgs; [
        pciutils
        pavucontrol
        playerctl
        nautilus
        element-desktop
        grim
        slurp
        libnotify
        wl-clipboard
        # wl-screenrec
      ]);
    shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#eveeifyeve --json |& nom --json";
  };
}
