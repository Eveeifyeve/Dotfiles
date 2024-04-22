{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs; [ vimPlugins.lazy-nvim ];
    colorschemes.gruvbox.enable = true;
    plugins.lightline.enable = true;
  };
}