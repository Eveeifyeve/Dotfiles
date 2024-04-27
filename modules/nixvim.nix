{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins = {
      lightline.enable = true;
      telescope.enable = true;
      lazy.enable = true;
      dashboard = {
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
      };
      hideStatusline = true;
      hideTabline = true;
    };
  };
}
