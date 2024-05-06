{
  config,
  pkgs,
  lib,
  username,
  email,
  ...
}:
{
  programs.home-manager.enable = true;
  home = {
    username = username;
    stateVersion = "22.05";
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      # Development Tools 
      vscode
      direnv
      devenv
      gradle
      btop
      ripgrep

      # Programs
      spotify
      raycast
      discord
      audacity
      postman
      iterm2

      # Nix Tools
      nixd
      nil

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  # Imports all modules from the ./modules directory that are not in the list of excluded modules above and apply's them to this configuration.
  imports = [../modules/programs.nix];

  # Nix Settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    allowed-users = [
      "eveeifyeve"
      "root"
    ];
    warn-dirty = false;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
}
