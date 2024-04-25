{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lightline.enable = true;
    plugins.telescope.enable = true;
    plugins.lazy.enable = true;
    plugins.dashboard = {
      enable = true;
      center =  [
      "Welcome to NixVim!"
      "Press ? for help"
    ];
    hideStatusline = true;
    hideTabline = true;
  };

 };
}