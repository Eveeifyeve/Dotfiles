{
  config,
  pkgs,
  ...
}:
let
  username = "eveeifyeve";
in
{
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';

  homebrew = {
    enable = true;
    casks = [
      "homebrew/cask/docker"
      "element"
      "cloudflare-warp"
			"logitech-g-hub"
    ];
    brews = [
      "brightness" # Adjust Screen Brightness on MacOS using CLI
    ];
    masApps = {
      GarageBand = 682658836;
      TestFlight = 899247664;
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

  environment = {
    loginShell = pkgs.zsh;
  };
}
