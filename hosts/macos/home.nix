{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../../modules/git.nix  ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
   home.file.".tmux.conf".source = ../../tmux.conf;
  home.packages = with pkgs; [
    (discord.override { withVencord = true; })
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
