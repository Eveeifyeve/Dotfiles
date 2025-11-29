{
  home.gui =
    hmArgs@{ pkgs, ... }:
    let
      cfg = hmArgs.config.stylix.fonts;
    in
    {
      stylix.fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        serif = cfg.monospace;
        sansSerif = cfg.monospace;
        emoji = cfg.monospace;
      };
    };
}
