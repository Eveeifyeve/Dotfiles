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
		../../modules/homemanager/deafult.nix
		../../modules/homemanager/terminal.nix
		../../modules/homemanager/git.nix
	];
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		systemd.enable = true;
		settings = {
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
			"exec-once" = [
				"wl-paste --type text --watch cliphist store"
				"wl-paste --type image --watch cliphist store"
			];

			bind = [
				"$mod SHIFT, L, exec, rofi -show run"
				"$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
				"$mod, T, exec, kitty"
				"$mod, C, killactive"
			] ++ (
				builtins.concatLists (builtins.genList (i: 
					let ws = i + 1;
					in [
						"$mod, code:1${toString i}, workspace, ${toString ws}"
						"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
					]
				)
				9)
			);
		};
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
	};

	programs = {
		rofi = {
			enable = true;
			theme = null;
		};
		waybar = {
			enable = true;
# TODO: Settings and style for waybar
			settings = [ ];
			style = null;
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

	services.cliphist.enable = true;

	home = {
		username = "eveeifyeve";
		stateVersion = "24.05";
		packages = pkgs.callPackage ../../modules/packages.nix { } 
		++ (with pkgs; [
			pciutils
			firefox
			pavucontrol
			xwaylandvideobridge
			wireplumber
			vesktop
		]);
		shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake /root/.dotfiles .#eveeifyeve --json |& nom --json";
	};
}
