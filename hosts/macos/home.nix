let
 excludedModules = [
    ../../modules/homebrew.nix
    ../../modules/nixvim.nix
 ];
in {
 config,
 pkgs,
 lib,
 username, 
 email,
 ...
}:
{
 imports =
    builtins.filter (module: !(builtins.elem module excludedModules))
      (
        builtins.map (module: ../../modules + "/${module}") (
          builtins.attrNames (builtins.readDir ../../modules)
        )
      );

 home.packages = with pkgs; [
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
    nixfmt-rfc-style

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
 ];
}