{
	config,
	pkgs,
	lib,
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
	};
	home = {
		username = "eveeifyeve";
		stateVersion = "24.05";
		packages = pkgs.callPackage ../../modules/packages.nix { } 
		++ (with pkgs; [
			
		]);
		shellAliases.nix-rebuild = "sudo nixos-rebuild switch --flake /root/.dotfiles .#eveeifyeve --json |& nom --json";
	};
}
