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
  programs.zsh.enable = true;
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
    sessionPath = ["$HOME/.local/bin" "/usr/local/bin" "/run/current-system/sw/bin" "/etc/profiles/per-user/eveeifyeve/bin"];
    shellAliases = {
      proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
      nix-rebuid = "darwin-rebuild switch --flake ~/.dotfiles";
      nix-direnv = "echo use flake . --impure > .envrc && direnv allow";
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
