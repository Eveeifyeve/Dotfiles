{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [../../modules/git.nix ../../modules/tmux.nix ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  home.shellAliases = {
   "nix-rebuild" = "darwin-rebuild switch --flake ~/.dotfiles";
  };
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    git
    vscode
    nil
    spotify
    raycast
    direnv
    nixd
    devenv
    tmux
    discord
    gradle
    iterm2
    btop
    audacity
    postman
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
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
}
