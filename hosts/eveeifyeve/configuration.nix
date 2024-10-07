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
    pkgs.gitMinimal
  ];
  
  users.users.eveeifyeve = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$1FNXj4e3flI0uJ.paVPFq/$2T/1y0PVRB0Le1h0UAg4pUNyWHG8Kyy0la9sNm86arC";
    extraGroups = ["nixos-config"];
  };
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
