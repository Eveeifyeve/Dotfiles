{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../../modules/git.nix ../../modules/tmux.nix  ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  home.file.".tmux.conf".source = ../../tmux.conf;
  home.packages = with pkgs; [
    git
    vscode
    nil
    spotify
    raycast
    direnv
    nixd
    devenv
    jetbrains.idea-community
    tmux
    discord
    gradle
    iterm2
    jetbrains-mono
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
