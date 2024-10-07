{
	lib,
  pkgs,
  ...
}:
{
  imports = [
    ./disk-config.nix
		./hardware-configuration.nix
  ];
	boot.loader = {
		efi.canTouchEfiVaribles = true;
		systemd-boot.enable = true;	
	};

  services.openssh.enable = true;

  environment.systemPackages = [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "CHANGE"
  ];

  system.stateVersion = "24.05";
}
