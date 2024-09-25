{ pkgs, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      lazygit.enable = true;
      lazy.enable = true;
      direnv.enable = true;
      # neocord.enable = true;
      ccc.enable = true;
      todo-comments.enable = true;
    };

    extraPlugins = [ (pkgs.callPackage ../../custom-pkgs/cord-nvim.nix { })];
    extraConfigLua = ''
      require("cord").setup({
      	display = {
      	  show_time = true,
      	  swap_fields = false,
      	  swap_icons = false,
      	},
      	ide = {
      	  enable = true,
      	  show_status = true,
      	  timeout = 300000,
      	  text = 'Idle',
      	  tooltip = '💤',
      	},
      	text = {
      	  viewing = 'Viewing {}',                    	 
      	  editing = 'Editing {}',                    
      	  file_browser = 'Browsing files in {}',     	  
      	  vcs = 'Committing changes in {}',
      	  workspace = 'In {}', 
      	  },
      })
    '';
  };
  imports = [
    ./settings.nix
    ./code.nix
    ./ui.nix
    # ./obsidian.nix 
  ];
}
