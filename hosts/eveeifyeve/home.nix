{
	config,
	pkgs,
	lib,
	inputs,
	...
}:
{
	imports = [
		../../modules/homemanager/deafult.nix
		../../modules/homemanager/terminal.nix
	];
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		systemd.enable = false;
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
			animation = {
				enabled = true;
			};
			"$mod" = "SUPER";
			bind = [
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
	home = {
		username = "eveeifyeve";
		stateVersion = "24.05";
		packages = pkgs.callPackage ../../modules/packages.nix { } 
		++ (with pkgs; [
			kitty
			pciutils
		]);
		shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake /root/.dotfiles .#eveeifyeve --json |& nom --json";
	};
}
