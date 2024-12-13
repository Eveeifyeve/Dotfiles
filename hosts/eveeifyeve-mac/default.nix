{ config, pkgs, ... }:
let
  username = "eveeifyeve";
in
{
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.nushell;
  };
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  environment.systemPackages = [ pkgs.nushell ];
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
  programs.zsh.enable = true;

	system.defaults.dock = {
		autohide = true;
		show-recents = false;
		mineffect = "scale";
		launchanim = false;
		tilesize = 16;
		minimize-to-application = true;
		persistent-apps = [
			"${pkgs.arc-browser}/Applications/Arc.app"
			"${pkgs.alacritty}/Applications/Alacritty.app"
			"${pkgs.obsidian}/Applications/Obsidian.app"
			"/System/Applications/Music.app"
		];
	};


  homebrew = {
    enable = true;
    casks = [
      "homebrew/cask/docker"
      "cloudflare-warp"
      # "logitech-g-hub"
    ];
    brews = [
      "brightness" # Adjust Screen Brightness on MacOS using CLI
    ];
    masApps = {
      GarageBand = 682658836;
      TestFlight = 899247664;
      CrystalFetch = 6454431289;
    };
    onActivation.cleanup = "uninstall";
  };

  # Garbage cleanup
  nix.gc = {
    user = "root";
    automatic = true;
    interval = [
      {
        Hour = 0;
        Minute = 0;
        Weekday = 0;
      }
    ];
    options = "--delete-older-than 14d";
  };
}
