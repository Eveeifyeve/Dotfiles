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
    ../../modules/homemanager/git.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings = {
      monitor = "eDP-1, 1920x1080@60, 0x0, 1, bitdepth, 8";
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
      # "$volumeControl" = builtins.readFile ./volume-control.sh;
      "exec-once" = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
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

      bind =
        [
          "$mod SHIFT, L, exec, rofi -show run"
          "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "$mod, T, exec, kitty"
          "$mod, C, killactive"
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

  programs = {
    rofi = {
      enable = true;
      theme = null;
      extraConfig = {
        show-icons = true;
      };
    };
    waybar = {
      enable = true;
      # TODO: Settings and style for waybar
      settings = [ ];
      style = ''
        				* {
        border: none;
        				border-radius: 10px;
        				}

        			window#waybar {
        background: rgba(22,22,28, 0.5);
        color: #AAB2BF;
        			}

        #workspaces button {
        padding: 0 5px;
        }
      '';
      systemd.enable = true;
    };
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      shellIntegration.enableZshIntegration = true;
    };
    hyprlock = {
      enable = true;
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
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkset";
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
        element
        grim
        slurp
        wl-clipboard
      ]);
    shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#eveeifyeve --json |& nom --json";
  };
}
