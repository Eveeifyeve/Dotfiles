{
  config,
  pkgs,
  lib,
  ...
}:
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
  nixpkgs.config.allowBroken = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  environment.systemPackages = [ pkgs.nushell ];
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.show-recents = false;
    dock.mineffect = "scale";
    dock.launchanim = false;
    dock.tilesize = 54;
    dock.minimize-to-application = true;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Welcome, Please login.";
    screencapture.location = "~/Pictures/screenshots";
    dock.persistent-apps = [
      "${pkgs.arc-browser}/Applications/Arc.app"
      "${pkgs.alacritty}/Applications/Alacritty.app"
      "${pkgs.obsidian}/Applications/Obsidian.app"
      "/System/Applications/Music.app"
    ];
  };

  nix.extraOptions = ''
      	extra-platforms = x86_64-darwin aarch64-darwin
    	'';

  homebrew = {
    enable = true;
    casks = [
      "homebrew/cask/docker"
      "cloudflare-warp"
      # "logitech-g-hub"
      "zen-browser@twilight"
      "tor-browser"
      "gimp@dev"
      "lmms"
      # "logitech-g-hub"
    ];
    brews = [
      "brightness" # Adjust Screen Brightness on MacOS using CLI
    ];
    masApps = {
      GarageBand = 682658836;
      TestFlight = 899247664;
      CrystalFetch = 6454431289;
      DaVinciResolve = 571213070;
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
