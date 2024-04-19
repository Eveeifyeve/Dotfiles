{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../../modules/git.nix ../../modules/direnv.nix  ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    neovim
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
