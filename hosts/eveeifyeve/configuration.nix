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

  environment.systemPackages = [
    pkgs.curl
    pkgs.gh
    pkgs.gitMinimal
  ];

	hardware.enableRedistributableFirmware = true;

	hardware.graphics = {
		package = hypr-unstable-pkgs.mesa.drivers;
		enable = true;
		enable32Bit = true;	
	};

	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
