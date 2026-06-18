{
  homeManager.modules.gui =
    { lib, pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = lib.optionals pkgs.stdenv.isDarwin pkgs.ghostty-bin;
        settings = {
          window-decoration = "none";
          macos-option-as-alt = true;
          background-blur = true;
        };
      };

      programs.tmux.extraConfig = "set -g @continuum-boot-options 'ghostty'";
    };
}
