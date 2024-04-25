{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lightline.enable = true;
    plugins.telescope.enable = true;
    plugins.lazy.enable = true;
    plugins.dashboard = {
      enable = true;
      center = [
        {
          desc = "Find project";
          icon = "📁";
          command = "Telescope find_files";
        }
        {
          desc = "Comfiguration";
          icon = "⚙️";
          command = "Telescope find_files ";
        }
      ];
      hideStatusline = true;
      hideTabline = true;
    };
  };
}
