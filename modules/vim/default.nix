{ pkgs, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      bufferline.enable = true;

      lazy.enable = true;
      direnv.enable = true;
      neocord.enable = true;
      ccc.enable = true;
      todo-comments.enable = true;
    };
  };
  imports = [
    ./settings.nix
    ./code.nix
    ./ui.nix
    # ./obsidian.nix 
  ];
}
