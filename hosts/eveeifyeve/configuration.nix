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
   mutableUsers = true;
   users."eveeifyeve" = {
    name = "eveeifyeve";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["nixos-config"];
   };
  };
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
