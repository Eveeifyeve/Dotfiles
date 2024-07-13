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
      "modrinth"
      "homebrew/cask/docker"
    ];
    masApps = {

    };
  };

  environment = {
    loginShell = pkgs.zsh;
  };
}
