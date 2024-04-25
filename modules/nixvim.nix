{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lightline.enable = true;
    plugins.lazy.enable = true;
  };
}