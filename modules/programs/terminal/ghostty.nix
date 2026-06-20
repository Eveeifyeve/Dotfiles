{
  homeManager.modules.gui =
    { pkgs, config, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        settings = {
          window-decoration = "none";
          macos-option-as-alt = true;
          background-blur = true;
        };
      };

      programs.tmux.extraConfig = "set -g @continuum-boot-options '${config.programs.ghostty.package}'";
    };
}
