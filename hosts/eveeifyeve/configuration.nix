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
    pkgs.gh
    pkgs.gitMinimal
  ];
  
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
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
