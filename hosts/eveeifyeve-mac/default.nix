{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.eveeifyeve.home = "/Users/eveeifyeve";
  ids.gids.nixbld = 350;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  system.stateVersion = 4;
  environment.systemPackages = with pkgs; [
    nushell
    podman
    podman-compose
  ];
  system.activationScripts.extraActivation.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
  system.primaryUser = "eveeifyeve";
  system.defaults.NSGlobalDomain = {
    NSWindowShouldDragOnGesture = true;
    ApplePressAndHoldEnabled = false;
  };
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
  programs.gnupg.agent.enable = true;

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
      "/System/Applications/Twilight.app"
      "${lib.getExe pkgs.alacritty}"
      "${lib.getExe pkgs.obsidian}"
      "/System/Applications/Music.app"
    ];
  };

  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin aarch64_linux
  '';

  # WORK!
  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    config = {
      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      nix.settings.experimental-features = "nix-command flakes";
      users.users."builder".extraGroups = [ "wheel" ];
      security.sudo.wheelNeedsPassword = false;
      virtualisation.cores = 8;
    };
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  homebrew = {
    enable = true;
    user = "eveeifyeve";
    casks = [
      "podman-desktop"
      "cloudflare-warp"
      "curseforge"
      "obs"
      "streamlabs"
      "zen@twilight"
      "gimp"
      "tor-browser"
      "lmms"
      "mixxx"
      "lunar-client"
      "anydesk"
      "blender"
      "roblox"
      "logitech-g-hub"
      "elgato-stream-deck"
      "wireshark-app"
      "libndi"
      "ndi-tools"
      "deskflow"
      "modrinth" # Until modrinth is fixed in nixpkgs.
    ];
    brews = [
      "brightness" # Adjust Screen Brightness on MacOS using CLI
    ];
    masApps = {
      GarageBand = 682658836;
      TestFlight = 899247664;
      CrystalFetch = 6454431289;
      DaVinciResolve = 571213070;
      Perplexity = 6714467650;
    };
    onActivation.cleanup = "uninstall";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Garbage cleanup
  nix.gc = {
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
