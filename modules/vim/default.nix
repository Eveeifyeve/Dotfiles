{ pkgs, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      bufferline.enable = true;
      lightline.enable = true;
      telescope.enable = true;
      lazy.enable = true;
      direnv.enable = true;
      neocord.enable = true;
      ccc.enable = true;
      codeium-nvim.enable = true;
      comment.enable = true;
      project-nvim.enable = true;
      todo-comments.enable = true;
      barbar = {
        enable = true;
        settings = {
          auto_hide = false;
        };
      };
      lualine = {
        enable = true;
      };
    };
    extraConfigLua = ''
      require('telescope').load_extension('projects')
    '';

  };
  imports = [ 
    ./settings.nix
    ./code.nix
    # ./obsidian.nix 
  ];
}
