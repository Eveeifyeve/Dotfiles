{
  config,
  pkgs,
  email,
  username,
  hostPlatform,
  ...
}:
{
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
  nixpkgs.hostPlatform = hostPlatform;
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
      "obsidian"
      "arc"
      "intellij-idea-ce"
      "curseforge"
    ];
    brews = [
      "brightness" # Adjust Screen Brightness on MacOS using CLI
    ];
    masApps = {
      GarageBand = 682658836;
      # Xcode = 497799835;
      TestFlight = 899247664;
    };
    onActivation.cleanup = "uninstall";
  };

  environment = {
    loginShell = pkgs.zsh;
  };
}
