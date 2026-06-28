{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, config, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        settings = {
          window-decoration = lib.optionalString pkgs.stdenv.isDarwin "none";
          macos-titlebar-style = lib.optionalString pkgs.stdenv.isDarwin "hidden";
          macos-option-as-alt = lib.optional pkgs.stdenv.isDarwin true;
          background-blur = true;
        };
      };

      programs.tmux.extraConfig = "set -g @continuum-boot-options '${config.programs.ghostty.package}'";
    };
}
