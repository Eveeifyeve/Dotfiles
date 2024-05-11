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

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    shellAliases = {
      proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
      nix-rebuild = "darwin-rebuild switch --flake ~/.dotfiles";
    };
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
