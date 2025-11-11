{ pkgs, lib, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;
    clipboard.providers.wl-copy.enable = lib.mkIf pkgs.stdenv.isLinux true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      lazygit.enable = true;
      cord = {
        enable = true;
        settings = {
          display.theme = "catppuccin";
          timestamp.reset_on_change = true;
        };
      };
      # lazy.enable = true;
      lz-n.enable = true;
      direnv.enable = true;
      ccc.enable = true;
      todo-comments.enable = true;
    };
  };
  imports = [
    ./settings.nix
    ./code.nix
    ./ui.nix
  ];
}
