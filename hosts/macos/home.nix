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
  imports = [../../modules/programs.nix];
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

      # Tools
      ffmpeg

      # Encoding Librarys
      libwebp

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

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
