{ pkgs, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;
    clipboard.providers.wl-copy.enable = true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      lazygit.enable = true;
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
