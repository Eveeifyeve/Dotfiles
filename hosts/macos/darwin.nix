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


  homebrew = {
    enable = true;
    casks = [
      "modrinth"
      "homebrew/cask/docker"
      "vmware-fusion"
    ];
    masApps = {

    };
  };

  environment = {
    loginShell = pkgs.zsh;
  };
}
