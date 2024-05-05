{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports =
    builtins.filter (module: module != ../../modules/homebrew.nix && module != ../../modules/nixvim.nix)
      (
        builtins.map (module: ../../modules + "/${module}") (
          builtins.attrNames (builtins.readDir ../../modules)
        )
      );

  home.packages = with pkgs; [
    # Development Tools 
    git
    vscode
    direnv
    devenv
    tmux
    gradle
    iterm2
    btop

    # Programs
    spotify
    raycast
    discord
    audacity
    postman

    # Nix Tools
    nixd
    nil
    nixfmt-rfc-style

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Shell Aliases to make things easier to type
  home.shellAliases = {
    "nix-rebuild" = "darwin-rebuild switch --flake ~/.dotfiles";
  };
}
