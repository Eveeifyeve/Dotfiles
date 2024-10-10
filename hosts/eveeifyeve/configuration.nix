{
	lib,
  pkgs,
	config,
	inputs,
  ...
}:
let
	hypr-unstable-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./disk-config.nix
  ];
	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot.enable = true;	
	};

  services = {
		openssh.enable = true;
		xserver.videoDrivers = ["amdgpu"];
	};

# Time

	networking.timeServers = ["time.nist.gov" "time.windows.com"];
	time.timeZone = "Australia/Sydney";

	environment.variables = {
# OZONE Settings
		NIXOS_OZONE_WL = "1";
		ELECTRON_OZONE_PLATFORM_HINT = "auto";

		MOZ_ENABLE_WAYLAND = "1";

# xdg settings
		NIXOS_XDG_OPEN_USE_PORTAL = "1";
		XDG_CURRENT_DESKTOP = "Hyprland";
		XDG_SESSION_DESKTOP = "Hyprland";
		XDG_SESSION_TYPE = "wayland";
	};

	hardware.enableRedistributableFirmware = true;

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	hardware.graphics = {
		package = hypr-unstable-pkgs.mesa.drivers;
		enable = true;
		enable32Bit = true;	
	};


	xdg.portal = {
		enable = true;
		config = {
			common = {
				default = ["hyprland" "gtk"];
				hyprland = ["hyprland" "gtk"];
			};
		};
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
	};

	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.hyprland;
	};

  users = {
   mutableUsers = false;
   users."eveeifyeve" = {
    name = "eveeifyeve";
    isNormalUser = true;
    hashedPassword = "$y$j9T$9Zg/83oVXDFMkTw27K2d5/$1SqsLU1.RbN.bPYsRZxL39p.k6F2XGXvJ9Aeq0ad718";
    shell = pkgs.zsh;
    extraGroups = ["nixos-config" "wheel"];
   };
  };
	nixpkgs.config = {
		allowUnfree = true;
		nvidia.acceptLicense = true;
	};
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
