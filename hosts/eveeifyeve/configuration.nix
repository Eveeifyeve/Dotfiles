{
	lib,
  pkgs,
  ...
}:
{
  imports = [
    ./disk-config.nix
  ];
	boot.loader = {
		efi.canTouchEfiVariables = true;
		systemd-boot.enable = true;	
	};

  services.openssh.enable = true;

  environment.systemPackages = [
    pkgs.curl
    pkgs.vim
    pkgs.gh
    pkgs.gitMinimal
  ];
  
  users = {
   users."eveeifyeve" = {
    name = "eveeifyeve";
    isNormalUser = true;
    hashedPassword = "$y$j9T$mlSYYayPPgLNWeNpoQ2KW/$9vznmgX1fFY.cSEWBLU45K/zCjvflmPoHcqlOOhAJ66";
    shell = pkgs.zsh;
    extraGroups = ["nixos-config" "wheel"];
   };
  };
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
